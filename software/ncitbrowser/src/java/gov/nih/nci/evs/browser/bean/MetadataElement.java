/*L
 * Copyright Northrop Grumman Information Technology.
 *
 * Distributed under the OSI-approved BSD 3-Clause License.
 * See http://ncip.github.com/nci-term-browser/LICENSE.txt for details.
 */

package gov.nih.nci.evs.browser.bean;

/**
  * 
  */

/**
  * @author EVS Team
  * @version 1.0
  *
  * Modification history
  *     Initial implementation kim.ong@ngc.com
  *
 */

public class MetadataElement {

	private String name;

	public MetadataElement(){

	}

	public MetadataElement(String name) {
		this.name = name;
	}


	public String getName() {
		return this.name;
	}



	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("MetadataElement ");
		sb.append("\n");
		sb.append("\tname: " + name);
		sb.append("\n");
		sb.append("\n");

		return sb.toString();
	}
}
