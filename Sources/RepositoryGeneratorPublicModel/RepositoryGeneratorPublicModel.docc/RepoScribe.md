# Getting started with RepoScribe

Configure the model using the repoScribe application

@Metadata {
    @PageImage(purpose: card, source: "repoScribe", alt: "Image of the repo scribe application")
}

## Overview

Import openapi 2.x & 3.x specification document, configure an instance of ``RepositoryGeneratorPublicModel/GlobalModel`` and launch you script to generate source code for your project.

![](repoScribe)

## Import open api specification document

On the left pannel there are two button:
* from file: Will import import open api specification file with yaml or json format.
* from clipboard: Will import open api specification content with yaml or json format from your clipboard.

## Filtering api call

![](filtering)

On the top right corner of the window you can access a text field to filter the api call.
In this textfield, you can enter a part or complete path to an api call.

You can filter api call by method using those tags:
* #post
* #get
* #put
* #delete

You can also filter api call by state using those tags:

* #selected
* #unselected

## Mapping basic type to your language of choice's basic type

In open api specification files you can find basic type like *integer*, *number$, *boolean*, *string*. To map those type you can access a type mapping settings type (**⌘** + **,**) then go to the **type Mapping** tab.

![](typeMapping)

To apply your mapping click **Edit > Apply mapping**

You can now choose to edit the **Default** mapping or **create a new Mapping** and change the alias values by the one you prefer. You may also rename a mapping's name by editing it in the **create a new Mapping**'s window.

## Setting additional information

To set additional information, type (**⌘** + **,**) then go to the **Additional information** tab.

![](additionalInformation)

## Link your generating script

To link your generating script, type (**⌘** + **,**) then go to the **Export** tab.
There you will find a single button to select you script file. (Guide to create your script).

### Featured

@Links(visualStyle: detailedGrid) {
    - <doc:CreateScript>
    - <doc:RepositoryGeneratorPublicModel>
}
