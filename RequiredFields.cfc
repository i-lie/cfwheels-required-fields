﻿<cfcomponent output="false">

	<cfset $initRequiredFields()>

	<cffunction name="init">
		<cfset this.version = "1.1.2,1.1.4,1.1.5,1.1.8">
		<cfreturn this>
	</cffunction>

	<cfinclude template="model/validations.cfm">
	<cfinclude template="view/forms.cfm">

	<cffunction name="$initRequiredFields" mixin="controller" hint="Initializes application variables used to generate the required field indicator.">
		<cfparam name="application.requiredFields.containerElement" type="string" default="span">
		<cfparam name="application.requiredFields.containerClass" type="string" default="required">
		<cfparam name="application.requiredFields.indicatorText" type="string" default="*">
	</cffunction>

</cfcomponent>