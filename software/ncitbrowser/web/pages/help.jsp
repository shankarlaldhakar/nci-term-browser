<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ page contentType="text/html;charset=windows-1252"%>
<%@ page import="java.util.Vector"%>
<%@ page import="org.LexGrid.concepts.Concept" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
  <title>NCI Thesaurus Browser Home</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/styleSheet.css" />
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/script.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/search.js"></script>
  <script type="text/javascript" src="<%= request.getContextPath() %>/js/dropdown.js"></script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<f:view>
  <%@ include file="/pages/templates/header.xhtml" %>
  <div class="center-page">
    <%@ include file="/pages/templates/sub-header.xhtml" %>
    <!-- Main box -->
    <div id="main-area">
      <%@ include file="/pages/templates/content-header.xhtml" %>
      <!-- Page content -->
      <div class="pagecontent">
        <!-- ======================================= -->
        <!--                 HELP CONTENT            -->
        <!-- ======================================= -->
        <div class="texttitle-blue">Help</div>
        <p class="textbody">
          <A HREF="#introduction">Introduction</A><br>
          <A HREF="#searchhelp">Search</A><br>
          <A HREF="#conceptdetails">Concept Details</A><br>
          <A HREF="#viewhierarchy">View Hierarchy</A><br>
          <A HREF="#subsets">Subsets</A><br>
          <A HREF="#knownissues">Known Issues</A><br>
          <A HREF="#additionalinfo">Additional Information</A>
        </p>
        <p class="textbody">
          <h2><A NAME="introduction">Introduction</A></h2>
          <b>NCI Thesaurus (NCIt)</b> is an extensive reference terminology
          with some complex features.  Each specific meaning, such as melanoma,
          lung, or chemotherapy, is represented by a distinct <i>concept</i>
          with a unique, permanent <i>code</i>.  Each concept provides 
          additional information such as a preferred name, other terms
          and codes, definitions, and relationships with other concepts.  
          Concepts are organized within major categories <i>(kinds)</i>,
          such as anatomy and gene, and arranged in logical parent-child
          hierarchies from very broad top concepts down to the most
          specific subcategories.
        </p>
        <p class="textbody">
          <b>The NCIt Browser</b> is designed for ease of use by a diverse
          user community.  This first release focuses on the data and
          features most users want.  Future releases will add advanced
          search options, user-defined reports, and other things users
          ask for.  For information on other NCIt browsers, file formats,
          and computer application access, see the
          <a href="http://evs.nci.nih.gov/">EVS web site</a>.
        </p>
        <p class="textbody">
          <% String contactUsUrl = request.getContextPath() + "/pages/contact_us.jsf"; %>
          <b>Get in touch</b> to get help or offer suggestions using the
          browser�s <a href="<%= contactUsUrl %>">Contact Us</a> page.
        </p>
        <p class="textbody">
          <b>This help file</b> provides basic information about how to
          use the NCIt Browser effectively.  It also provides pointers
          on how to learn more about NCIt and related resources.
        </p>

        <p class="textbody">
          <h2><A NAME="searchhelp">Search</A></h2>
          <b>In the Search box</b>, enter all or part of what you are looking for and click the "Search" button. Some details:
          <ul>
            <li>You can search for a concept�s preferred name, synonyms, acronyms, or codes.
            <li>"Exact Match" is the default: Only terms or codes that are identical will match.
            <li>"Begins With" can be selected to find all terms or codes that start with the words or characters you enter.
            <li>"Contains" will search for what you enter anywhere within a term or code (e.g., "carcinoma" will match <i>adenocarcinoma</i>).
            <li>Search is not case sensitive (e.g., aids will match <i>aids</i>, <i>Aids</i>, and <i>AIDS</i>).
            <li>There are no wildcard characters.  All characters are matched literally (e.g., using "Begins With", NAT2* will match <i>NAT2*5 Allele</i> but not <i>NAT2 Gene</i>).
            <li>Searching for multiple words does not search on each word separately.  To match, all words have to be found in the same order you provided.  For example, if you do a �Contains� search on �Melanoma Corneal,� no results will be returned.  But if you search on �Corneal Melanoma,� you get the detail page for Corneal Melanoma.</li>
            
          </ul>
          Search of other concept data, approximate matching, and other features will be added to future releases of this
          browser. Some of these features are currently available in the <a href="http://bioportal.nci.nih.gov/ncbo/faces/index.xhtml">NCI BioPortal Browser</a>.
        </p>
        
        <p class="textbody">
          <b>Search results</b> are displayed by concept preferred name in
          alphabetical order .  (If there is only one match, the concept
          details page is shown directly without first listing results.)
          Some details:
            <ul>
              <li>All matching concepts are returned.</li> 
              <li>The match will often be to synonyms or codes only visible on the concept details page (e.g., searching �Begins With� melanoma will show <i>Corneal Melanoma</i> in the results list because that concept contains a synonym of <i>Melanoma of the Cornea</i>.) A future release will show these matches in the results window.</li>
              <li>If there are too many to show on one page, you can page through the results with a default of 50 per page. To change the default number, use the �Show results per page� drop-down menu at the bottom of the results page.</li>
              <li>In the next release, concepts whose status is unusual (e.g., retired or obsolete) will show their status in parentheses in the results listing.</li>
              <li>Click on the preferred name to see a concept�s details.</li>
            </ul>
        </p>
        
        <p class="textbody">
          <h2><A NAME="conceptdetails">Concept Details</A></h2>
          
          Detailed information on the selected concept is grouped and shown on several related pages:
          <ul>
            <li>Tabbed information gives the concept�s meaning, labels, and direct relationships:</li>
            <ul> 
              <li><b>Terms & Properties:</b> Gives definitions, synonyms, abbreviations, codes, and other information.</li>
              <li><b>Relationships:</b> Shows how other concepts are directly related to this concept as  parents, children, or in other ways.</li>
              <li><b>Synonym Details:</b> For each term or abbreviation, shows its term type, source, and code (for outside sources that have them).</li>
              <li><b>View All:</b> Combines all of the above information on a single page.</li>
            </ul> 
            <li><b>View in Hierarchy</b> button � click on this to see where the concept exists within the NCI Thesaurus hierarchy.  The focused concept will be bold, underlined, and colored red.</li>  
            <li><b>View History</b> button � click on this to view a history of edit actions on this concept, including dates and reference concepts.</li>
          </ul>
        </p>
        
        
        <p class="textbody">
          <h2><A NAME="viewhierarchy">View Hierarchy</A></h2>
          <ul>
            <li>Click on the <b>View Hierarchy</b> link at the top of the page to bring up a separate window showing the NCI Thesaurus hierarchy.
            <li>Browse through the levels by clicking on the + next to each concept.
            <li>Click on the concept name itself to see the concept�s details in the main browser window.
          </ul>
        </p>
        <p class="textbody">
          <h2><A NAME="subsets">Subsets</A></h2>
          <ul>
            <li>Click on the <b>Subsets</b> link at the top of the page to read about and link to NCI Thesaurus Subsets.
          </ul>
        </p>

        <p class="textbody">
          <h2><A NAME="knownissues">Known Issues</A></h2>
          <ul>
            <li>Single character?</li>
          </ul>
        </p>

        <p class="textbody">
          <h2><A NAME="additionalinfo">Additional Information</A></h2>
          Sources
          <br/>Versions: browser, data
          <br/>Several journal articles describe NCIt in greater detail.  These are listed in the <a href="http://evs.nci.nih.gov/aboutEVS">About EVS</a> page on the EVS Web site.
          <br/>(Need to make available, describe, and link to other NCIt documentation.  This section will be provided soon.)
        </p>
        <br>
        <%@ include file="/pages/templates/nciFooter.html" %>
      </div>
      <!-- end Page content -->
    </div>
    <div class="mainbox-bottom"><img src="<%=basePath%>/images/mainbox-bottom.gif" width="745" height="5" alt="Mainbox Bottom" /></div>
    <!-- end Main box -->
  </div>
</f:view>
</body>
</html>