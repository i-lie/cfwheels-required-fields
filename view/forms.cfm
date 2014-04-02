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

<cffunction name="$appendRequiredFieldIndicator" mixin="controller" returntype="string" hint="Adds return value to label and returns it.">
	<cfargument name="label" type="string" required="true" hint="Label to modify.">
	<cfargument name="requiredFieldsContainerElement" type="string" required="false" default="#application.requiredFields.containerElement#" hint="">
	<cfargument name="requiredFieldsContainerClass" type="string" required="false" default="#application.requiredFields.containerClass#" hint="">
	<cfargument name="requiredFieldsIndicatorText" type="string" required="false" default="#application.requiredFields.indicatorText#" hint="">

	<cfscript>
		var loc = { label=arguments.label };

		loc.label &= " ";
		if (Len(arguments.requiredFieldsContainerElement)) {
			loc.label &= '<#arguments.requiredFieldsContainerElement#';

			if(Len(application.requiredFields.containerClass)) {
				loc.label &= ' class="#arguments.requiredFieldsContainerClass#"';
			}

			loc.label &= '>';
		}

		loc.label &= arguments.requiredFieldsIndicatorText;

		if (Len(arguments.requiredFieldsContainerElement))
		{
			loc.label &= '</#arguments.requiredFieldsContainerElement#>';
		}
	</cfscript>

	<cfreturn loc.label>
</cffunction>