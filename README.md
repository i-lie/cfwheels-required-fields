# Required Fields

## What is it?

This is a forked of https://github.com/liquifusion/cfwheels-required-fields

Use this plugin to append a marked up asterisk to the labels of required fields.
It determines this by looking at validations set on the object form helpers' properties to determine whether or not validatesPresenceOf() is set (manually or automatically).

## History

### Version 0.6.1

* Don't remove the required tag from input form since it is a valid attribute in HTML5
* Add requiredFieldsContainerElement, requiredFieldsContainerClass and requiredFieldsIndicatorText arguments so any textField(), textFieldTag(), textAreaField(), etc can override the default setting
Sometimes, there might be a need to not showing the required indicator text eventhough it is required.
