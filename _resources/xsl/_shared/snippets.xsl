<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp   "&#160;">
<!ENTITY lsaquo   "&#8249;">
<!ENTITY rsaquo   "&#8250;">
<!ENTITY laquo  "&#171;">
<!ENTITY raquo  "&#187;">
<!ENTITY copy   "&#169;">
<!ENTITY apos   "&#39;">
<!ENTITY quot   "&#34;">
<!ENTITY mdash   "&#8212;">
<!ENTITY lsquo   "&#8216;">
<!ENTITY middot "&#183;">
<!ENTITY ldquo "&#x0201C;">
<!ENTITY rdquo "&#x0201D;">
]>

<xsl:stylesheet version="3.0"
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:xs="http://www.w3.org/2001/XMLSchema"
				xmlns:ou="http://omniupdate.com/XSL/Variables"
				xmlns:fn="http://omniupdate.com/XSL/Functions"
				xmlns:ouc="http://omniupdate.com/XSL/Variables"
				exclude-result-prefixes="xs ou fn ouc">

	<xsl:import href="template-matches.xsl"/>
	<xsl:import href="functions.xsl"/> 
  
	<!-- Contact List -->	

	<xsl:template match="table[@class='ou-contact-us-box']">
		<xsl:variable name="cols" select="count(tbody/tr/td)" />


		<xsl:variable name="contact-us-box-header">
			<xsl:choose>
				<xsl:when test="thead/tr/td[@class='ou-contact-us-box-header']/text() and (thead/tr/td[@class='ou-contact-us-box-header']/text() != '&nbsp;')">
					<xsl:value-of select="normalize-space(replace(thead/tr/td[@class='ou-contact-us-box-header']/text(), '&nbsp;', ''))"/>
				</xsl:when>
				<xsl:otherwise>Contact Us</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- option for alignment, default to center valign -->
		<xsl:variable name="contact-us-box-alignment">
			<xsl:choose>
				<xsl:when test="thead/tr/td[@class='ou-contact-us-box-alignment']/text() = 'top'">contact-us-box-valign-top</xsl:when>
				<xsl:otherwise>contact-us-box-valign-center</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>


		<xsl:if test="$cols gt 0">
			<div class="contact-us-box contact-us-box-flex {$contact-us-box-alignment}">
				<h2><xsl:value-of select="$contact-us-box-header"/></h2>
				<div class="content-blocks">
					<xsl:for-each select="tbody/tr/td">
						<xsl:variable name="pos" select="position()"/>

						<div>
							<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="count(./iframe) gt 0">content-block content-block-iframe</xsl:when>
									<xsl:otherwise>content-block</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>  
							<div class="content-block-interior">
								<div class="content-block-interior-content">
									<xsl:apply-templates select="./node()" />
								</div> 
							</div>						
						</div>

					</xsl:for-each>
				</div> 
			</div>
		</xsl:if>

	</xsl:template>

	<xsl:template match="table[@class='ou-contact-us-box']/tbody/tr/td/iframe">		
		<div class="flex-video">			
			<xsl:variable name="vidsrc" select="./@src"/>
			<iframe title="Map of location" src="{$vidsrc}" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
		</div>
	</xsl:template>


	<!-- 	
/* Contact List: select-list managed in /_resources/ou/editor/select-lists/contact-list.json
/* Outputs selected items in a formatted way for contact boxes
-->
	<xsl:template match="ouc:div//table[contains(@class, 'ou-contact-list')]">
		<xsl:if test="count(tbody/tr) gt 0">
			
				<dl class="list-icons">
					<xsl:for-each select="tbody/tr">
						<xsl:variable name="posunused" select="td[1]/node()" />
						<xsl:variable name="val" select="td[@data-select-list='contact-types']/text()" />

						<xsl:choose>
							<xsl:when test="$val = 'Phone (Numbers only)'">	
								<dt><span class="fa fa-phone-alt" aria-hidden="true"></span><span class="sr-only">Phone</span></dt>
								<dd>
									<xsl:call-template name="ou-phone-link">			
										<xsl:with-param name="phone-number" select="td[2]/text()" />
									</xsl:call-template>
								</dd>
							</xsl:when>
							<xsl:when test="$val = 'Fax (Numbers only)'">	
								<dt><span class="far fa-fax" aria-hidden="true"></span><span class="sr-only">Fax</span></dt>
								<dd>
									<xsl:call-template name="ou-phone-fax">			
										<xsl:with-param name="phone-number" select="td[2]/text()" />
									</xsl:call-template>
								</dd>
							</xsl:when>
							<xsl:when test="$val = 'Email Address'">
								<dt><span class="far fa-envelope" aria-hidden="true"></span><span class="sr-only">Email</span></dt>
								<dd>
									<xsl:call-template name="ou-email-link">			
										<xsl:with-param name="email" select="td[2]/text()" />
									</xsl:call-template>
								</dd>
							</xsl:when>

							<xsl:when test="$val = 'Location (Simple)'">
								<dt><span class="fas fa-map-marker-alt" aria-hidden="true"></span><span class="sr-only">Location</span></dt>
								<dd><xsl:apply-templates select="td[2]/node()" /></dd>
							</xsl:when>

							<xsl:when test="$val = 'Person'">
								<dt><span class="far fa-user" aria-hidden="true"></span><span class="sr-only">Contact</span></dt>
								<dd><xsl:apply-templates select="td[2]/node()" /></dd>
							</xsl:when>
							
							<xsl:when test="$val = 'Video Chat'">
								<dt><span class="far fa-video" aria-hidden="true"></span><span class="sr-only">Video Chat</span></dt>
								<dd><xsl:apply-templates select="td[2]/node()" /></dd>
							</xsl:when>
							
							<xsl:when test="$val = 'Hours (Simple)'">
								<dt><span class="far fa-clock" aria-hidden="true"></span><span class="sr-only">Hours</span></dt>
								<dd><xsl:apply-templates select="td[2]/node()" /></dd>
							</xsl:when>
							
							<xsl:otherwise>
								<dt class="unformatted"></dt>
								<dd><xsl:apply-templates select="td[2]/node()" /></dd>
							</xsl:otherwise>

						</xsl:choose>

					</xsl:for-each> 

				</dl> 
		</xsl:if>
	</xsl:template>
	
	<!-- Set up definition list for showing building map link -->
	<xsl:template match="ouc:div//table[contains(@class, 'ou-contact-location')]">
		<xsl:if test="count(tbody/tr) gt 0">
			<dl class="list-icons">
				<xsl:for-each select="tbody/tr">
					<xsl:variable name="posunused" select="td[1]/node()" />
					<xsl:variable name="val" select="td[@data-select-list='contact-types']/text()" />
					<dt><span class="fas fa-map-marker-alt" aria-hidden="true"></span><span class="sr-only">Location</span></dt>
					<dd>
						<xsl:call-template name="ou-location-link">			
							<xsl:with-param name="location" select="td[2]/text()" />
						</xsl:call-template>
					</dd>
				</xsl:for-each>
			</dl>
		</xsl:if>
	</xsl:template>
	
	<!-- Using select lists in ou/editor/select-lists/contact-locations.json, product a map link -->
	<xsl:template name="ou-location-link">
		<xsl:param name="location" />
		<xsl:variable name="gMap" select="'https://www.google.com/maps/place/'" />
		<xsl:variable name="city" select="'+Shoreline,+WA+98133'" />
		<xsl:variable name="gMapName"><xsl:call-template name="ou-location-gmap-name"><xsl:with-param name="location" select="$location" /></xsl:call-template></xsl:variable>
		
		<a class="link-email" href="{$gMap}{$gMapName}{$city}" title="View map on Google Maps"> 
			<xsl:value-of select="$location" />
		</a>
	</xsl:template>

	<!-- Based on given location name from Map listing, output the name to be used in the Google Maps link -->
	<xsl:template name="ou-location-gmap-name">
		<xsl:param name="location" />		
		<xsl:choose>
			<xsl:when test="$location = '800 Building (Music)'">800+Building+(Music),</xsl:when>
			<xsl:when test="$location = '1000 Building (Administration)'">1000+Building,</xsl:when>
			<xsl:when test="$location = '1100 Building'">1100+Building,</xsl:when>
			<xsl:when test="$location = '1200 Building (Business Office)'">1200+Building,</xsl:when>
			<xsl:when test="$location = '1300 Building (Computer Lab)'">1300+Building,</xsl:when>
			<xsl:when test="$location = '1400 Building'">1400+Building,</xsl:when>
			<xsl:when test="$location = '1500 Building'">1500+Building,</xsl:when>
			<xsl:when test="$location = '1600 Building (Theater)'">Building+1600+%26+1700,</xsl:when>
			<xsl:when test="$location = '1700 Building'">Building+1600+%26+1700,</xsl:when>
			<xsl:when test="$location = '1800 Building'">1800+Building,</xsl:when>
			<xsl:when test="$location = '1900 Building (Child Care Center)'">1900+Building,</xsl:when>
			<xsl:when test="$location = '2000 Building (Visual Arts Center)'">2000+Building,</xsl:when>
			<xsl:when test="$location = '2100 Building (Professional Automotive Technology Center)'">2100+Building,</xsl:when>
			<xsl:when test="$location = '2200 Building'">2200+Building,</xsl:when>
			<xsl:when test="$location = '2300 Building (Nursing)'">2300+Building,</xsl:when>
			<xsl:when test="$location = '2400 Building'">2400+and+2600+Building,</xsl:when>
			<xsl:when test="$location = '2500 Building (Dental Hygiene and CNC)'">2500+Building,</xsl:when>
			<xsl:when test="$location = '2600 Building (Science Lab)'">2400+and+2600+Building,</xsl:when>
			<xsl:when test="$location = '2700 Building'">2700+Building,</xsl:when>
			<xsl:when test="$location = '2800 Building (Math/Science Office)'">2800+Building,</xsl:when>
			<xsl:when test="$location = '2900 Building'">2900+Building,</xsl:when>
			<xsl:when test="$location = '3000 Building (Gym)'">3000+Building,</xsl:when>
			<xsl:when test="$location = '5000 Building (FOSS)'">Admissions+and+Records,</xsl:when>
			<xsl:when test="$location = '9000 Building (PUB)'">Pagoda+Union+Building,</xsl:when>
			<xsl:when test="$location = '4000 Building (Library)'">4000+Building,</xsl:when> 
			<xsl:otherwise><xsl:value-of select="$location" /></xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!-- 	
/* Contact hours: select-list managed in /_resources/ou/editor/select-lists/contact-hours.json
/* Outputs formatted hours based on current day of week
-->
	<xsl:template match="ouc:div//table[contains(@class, 'ou-contact-hours')]">
		<xsl:if test="count(tbody/tr) gt 0"> 
			<dl class="list-icons">
				<dt><span class="far fa-clock" aria-hidden="true"></span><span class="sr-only">Hours</span></dt>
				<dd><dl class="contact-hours">
					<xsl:for-each select="tbody/tr">
						<xsl:variable name="posunused" select="td[1]/node()" />
						<xsl:variable name="val" select="td[1]/text()" />

						<dt class="contact-hours-{$val}">
							<xsl:choose>		
								<xsl:when test="$val = 'Monday'">Mon</xsl:when>
								<xsl:when test="$val = 'Tuesday'">Tues</xsl:when>
								<xsl:when test="$val = 'Wednesday'">Wed</xsl:when>
								<xsl:when test="$val = 'Thursday'">Thurs</xsl:when>
								<xsl:when test="$val = 'Friday'">Fri</xsl:when>
								<xsl:when test="$val = 'Saturday'">Sat</xsl:when>
								<xsl:when test="$val = 'Sunday'">Sun</xsl:when>
							</xsl:choose>
						</dt>
						<dd class="contact-hours-{$val}">
							<xsl:value-of select="td[2]/text()" />
						</dd>

					</xsl:for-each> 
					</dl> 
				</dd>
			</dl>
		</xsl:if>
	</xsl:template> 

	<xsl:template name="ou-phone-link">
		<xsl:param name="phone-number" />  	
		<a class="link-phone" href="tel:{$phone-number}">
			<xsl:value-of select="concat('(', substring($phone-number, 1, 3), ') ', substring($phone-number, 4, 3), '-', substring($phone-number, 7, 4))" />
		</a> 
	</xsl:template>
	
	<xsl:template name="ou-phone-fax">
		<xsl:param name="phone-number" />  	
		<xsl:value-of select="concat('(', substring($phone-number, 1, 3), ') ', substring($phone-number, 4, 3), '-', substring($phone-number, 7, 4))" />
	</xsl:template>
	
	<xsl:template name="ou-email-link">
		<xsl:param name="email" />  	
		<a class="link-email" href="mailto:{$email}">
			<xsl:value-of select="$email" />
		</a>
	</xsl:template>
	  
</xsl:stylesheet>
