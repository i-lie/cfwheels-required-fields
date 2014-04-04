<cffunction name="$getFieldLabel" mixin="controller" returntype="string" access="public" output="false">
	<cfargument name="objectName" type="any" required="true">
	<cfargument name="property" type="string" required="true">
	<cfargument name="label" type="string" required="true">

	<cfscript>
		var loc = {};

		loc.coreGetFieldLabel = core.$getFieldLabel;
		loc.label = loc.coreGetFieldLabel(argumentCollection=arguments);

		arguments.label = loc.label;

		if (IsSimpleValue(arguments.objectName))
		{
			loc.object = Evaluate(arguments.objectName);
			if (loc.object.isNew())
			{
				loc.when = "onCreate,onSave";
			}
			else {
				loc.when = "onUpdate,onSave";
			}

			if (( IsObject(loc.object) && Len(loc.label) && loc.object.$validationExists(arguments.property, "validatesPresenceOf")
				&& ( !StructKeyExists(arguments, "required") || (StructKeyExists(arguments, "required") && arguments.required) ) )
				|| ( StructKeyExists(arguments, "required") && arguments.required ))
			{
				loc.label = $appendRequiredFieldIndicator(argumentCollection: arguments);
			}
		}

		else if (StructKeyExists(arguments, "required") && arguments.required)
		{
			loc.label = $appendRequiredFieldIndicator(argumentCollection: arguments);
		}
	</cfscript>

	<cfreturn loc.label>
</cffunction>

<cffunction name="$createLabel" returntype="string" access="public" output="false">
	<cfargument name="objectName" type="any" required="true">
	<cfargument name="property" type="string" required="true">
	<cfargument name="label" type="string" required="true">
	<cfargument name="prependToLabel" type="string" required="true">
	<cfargument name="labelRequiredFieldsContainerElement" type="string" required="false" default="#application.requiredFields.containerElement#" hint="">
	<cfargument name="labelRequiredFieldsContainerClass" type="string" required="false" default="#application.requiredFields.containerClass#" hint="">
	<cfargument name="labelRequiredFieldsIndicatorText" type="string" required="false" default="#application.requiredFields.indicatorText#" hint="">

	<cfscript>
		var loc = {};
		var loc.skipArgs = "labelRequiredFieldsContainerElement,labelRequiredFieldsContainerClass,labelRequiredFieldsIndicatorText";

		// delete the requireFields arguments so it doesn't get added to the label tag
		loc.iEnd = ListLen(loc.skipArgs);
		for (loc.i = 1; loc.i <= loc.iEnd; loc.i++) {
			StructDelete(arguments, ListGetAt(loc.skipArgs, loc.i, ","));
		}

		return core.$createLabel(argumentcollection: arguments);
	</cfscript>
</cffunction>

<cffunction name="$appendRequiredFieldIndicator" mixin="controller" returntype="string" hint="Adds return value to label and returns it.">
	<cfargument name="label" type="string" required="true" hint="Label to modify.">
	<cfargument name="labelRequiredFieldsContainerElement" type="string" required="false" default="#application.requiredFields.containerElement#" hint="">
	<cfargument name="labelRequiredFieldsContainerClass" type="string" required="false" default="#application.requiredFields.containerClass#" hint="">
	<cfargument name="labelRequiredFieldsIndicatorText" type="string" required="false" default="#application.requiredFields.indicatorText#" hint="">

	<cfscript>
		var loc = { label=arguments.label };

		loc.label &= " ";
		if (Len(arguments.labelRequiredFieldsContainerElement)) {
			loc.label &= '<#arguments.labelRequiredFieldsContainerElement#';

			if(Len(application.requiredFields.containerClass)) {
				loc.label &= ' class="#arguments.labelRequiredFieldsContainerClass#"';
			}

			loc.label &= '>';
		}

		loc.label &= arguments.labelRequiredFieldsIndicatorText;

		if (Len(arguments.labelRequiredFieldsContainerElement))
		{
			loc.label &= '</#arguments.labelRequiredFieldsContainerElement#>';
		}
	</cfscript>

	<cfreturn loc.label>
</cffunction>