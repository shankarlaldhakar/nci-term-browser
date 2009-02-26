
package gov.nih.nci.evs.browser.bean;

import java.io.File;

import gov.nih.nci.evs.browser.utils.SortUtils;
import gov.nih.nci.evs.browser.utils.SearchUtils;

import gov.nih.nci.evs.browser.properties.NCItBrowserProperties;

import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import java.util.HashSet;
import java.util.Date;

import javax.faces.context.FacesContext;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import java.util.Collection;

import org.LexGrid.concepts.Concept;

import gov.nih.nci.evs.browser.properties.NCItBrowserProperties;

/**
  * <!-- LICENSE_TEXT_START -->
* Copyright 2008,2009 NGIT. This software was developed in conjunction with the National Cancer Institute,
* and so to the extent government employees are co-authors, any rights in such works shall be subject to Title 17 of the United States Code, section 105.
* Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
* 1. Redistributions of source code must retain the above copyright notice, this list of conditions and the disclaimer of Article 3, below. Redistributions
* in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other
* materials provided with the distribution.
* 2. The end-user documentation included with the redistribution, if any, must include the following acknowledgment:
* "This product includes software developed by NGIT and the National Cancer Institute."
* If no such end-user documentation is to be included, this acknowledgment shall appear in the software itself,
* wherever such third-party acknowledgments normally appear.
* 3. The names "The National Cancer Institute", "NCI" and "NGIT" must not be used to endorse or promote products derived from this software.
* 4. This license does not authorize the incorporation of this software into any third party proprietary programs. This license does not authorize
* the recipient to use any trademarks owned by either NCI or NGIT
* 5. THIS SOFTWARE IS PROVIDED "AS IS," AND ANY EXPRESSED OR IMPLIED WARRANTIES, (INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
* MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE) ARE DISCLAIMED. IN NO EVENT SHALL THE NATIONAL CANCER INSTITUTE,
* NGIT, OR THEIR AFFILIATES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
* PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  * <!-- LICENSE_TEXT_END -->
  */

/**
  * @author EVS Team
  * @version 1.0
  *
  * Modification history
  *     Initial implementation kim.ong@ngc.com
  *
 */

public class UserSessionBean extends Object
{
	private static Logger KLO_log = Logger.getLogger("UserSessionBean KLO");

	private String selectedQuickLink = null;
	private List quickLinkList = null;

	public void setSelectedQuickLink(String selectedQuickLink) {
		this.selectedQuickLink = selectedQuickLink;
		HttpServletRequest request = (HttpServletRequest)FacesContext.getCurrentInstance().getExternalContext().getRequest();
		request.getSession().setAttribute("selectedQuickLink", selectedQuickLink);
	}

	public String getSelectedQuickLink() {
		return this.selectedQuickLink;
	}


	public void quickLinkChanged(ValueChangeEvent event) {
		if (event.getNewValue() == null) return;
		String newValue = (String) event.getNewValue();

		System.out.println("quickLinkChanged; " + newValue);
        setSelectedQuickLink(newValue);

		HttpServletResponse response = (HttpServletResponse)FacesContext.getCurrentInstance().getExternalContext().getResponse();

	    String targetURL = null;//"http://nciterms.nci.nih.gov/";
	    if (selectedQuickLink.compareTo("NCI Terminology Browser") == 0) {
		   targetURL = "http://nciterms.nci.nih.gov/";
	    }
	    try {
	    	response.sendRedirect(response.encodeRedirectURL(targetURL));
		} catch (Exception ex) {
			ex.printStackTrace();
			// send error message
		}

	}



	public List getQuickLinkList() {
		quickLinkList = new ArrayList();
		quickLinkList.add(new SelectItem("Quick Links"));
		quickLinkList.add(new SelectItem("NCI Terminology Browser"));
		quickLinkList.add(new SelectItem("NCI MetaThesaurus"));
		quickLinkList.add(new SelectItem("EVS Home"));
		quickLinkList.add(new SelectItem("NCI Terminology Resources"));
		return quickLinkList;
    }


	public String searchAction() {
		HttpServletRequest request = (HttpServletRequest)FacesContext.getCurrentInstance().getExternalContext().getRequest();

		String matchText = (String) request.getParameter("matchText");
		request.getSession().setAttribute("matchText", matchText);

		String matchAlgorithm = (String) request.getParameter("algorithm");
		setSelectedAlgorithm(matchAlgorithm);

		String scheme = "NCI Thesaurus";
		String version = null;

		String max_str = null;
		int maxToReturn = 1000;
		try {
			max_str = NCItBrowserProperties.getInstance().getProperty(NCItBrowserProperties.MAXIMUM_RETURN);
			maxToReturn = Integer.parseInt(max_str);
		} catch (Exception ex) {

		}
		request.getSession().setAttribute("vocabulary", scheme);

        long ms = System.currentTimeMillis();
		Vector<org.LexGrid.concepts.Concept> v = SearchUtils.searchByName(scheme, version, matchText, matchAlgorithm, maxToReturn);
		SortUtils.quickSort(v);

        if (v != null && v.size() > 0)
        {
        	request.getSession().setAttribute("search_results", v);
        	String match_size = Integer.toString(v.size());
        	request.getSession().setAttribute("match_size", match_size);
        	request.getSession().setAttribute("page_string", "1");
        	request.getSession().setAttribute("selectedResultsPerPage", "50");
        	return "search_results";
		}

		String message = "No match found.";
		request.getSession().setAttribute("message", message);
		return "message";

	}



	private String selectedResultsPerPage = null;
	private List resultsPerPageList = null;

	public List getResultsPerPageList() {
		resultsPerPageList = new ArrayList();
		resultsPerPageList.add(new SelectItem("10"));
		resultsPerPageList.add(new SelectItem("25"));
		resultsPerPageList.add(new SelectItem("50"));
		resultsPerPageList.add(new SelectItem("75"));
		resultsPerPageList.add(new SelectItem("100"));
		resultsPerPageList.add(new SelectItem("250"));
		resultsPerPageList.add(new SelectItem("500"));

		selectedResultsPerPage = ((SelectItem) resultsPerPageList.get(2)).getLabel(); // default to 50
		return resultsPerPageList;
	}

	public void setSelectedResultsPerPage(String selectedResultsPerPage) {
		this.selectedResultsPerPage = selectedResultsPerPage;
		HttpServletRequest request = (HttpServletRequest)FacesContext.getCurrentInstance().getExternalContext().getRequest();
		request.getSession().setAttribute("selectedResultsPerPage", selectedResultsPerPage);
	}

	public String getSelectedResultsPerPage() {
		return this.selectedResultsPerPage;
	}


	public void resultsPerPageChanged(ValueChangeEvent event) {
		if (event.getNewValue() == null) return;
		String newValue = (String) event.getNewValue();

		System.out.println("resultsPerPageChanged; " + newValue);
        setSelectedResultsPerPage(newValue);

	}



	public String linkAction() {
		HttpServletRequest request = (HttpServletRequest)FacesContext.getCurrentInstance().getExternalContext().getRequest();
/*
		String link = (String) request.getParameter("link");
		if (link.compareTo("NCI Terminology Browser") == 0)
		{
			return "nci_terminology_browser";
		}
		return "message";
*/
        return "";
	}

	private String selectedAlgorithm = null;
	private List algorithmList = null;

	public List getAlgorithmList() {
		algorithmList = new ArrayList();
		algorithmList.add(new SelectItem("exactMatch", "exactMatch"));
		algorithmList.add(new SelectItem("startsWith", "Begins With"));
		algorithmList.add(new SelectItem("contains", "Contains"));
		selectedAlgorithm = ((SelectItem) algorithmList.get(0)).getLabel();
		return algorithmList;
	}

	public void algorithmChanged(ValueChangeEvent event) {
		if (event.getNewValue() == null) return;
		String newValue = (String) event.getNewValue();

		System.out.println("algorithmChanged; " + newValue);
        setSelectedAlgorithm(newValue);
	}

	public void setSelectedAlgorithm(String selectedAlgorithm) {
		this.selectedAlgorithm = selectedAlgorithm;
		HttpServletRequest request = (HttpServletRequest)FacesContext.getCurrentInstance().getExternalContext().getRequest();
		request.getSession().setAttribute("selectedAlgorithm", selectedAlgorithm);
	}

	public String getSelectedAlgorithm() {
		return this.selectedAlgorithm;
	}


  }
