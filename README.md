# container-version-notification-azure-logic-app
This repo contains the resources to deploy an Azure Logic App that uses configuration stored in an Azure Storage Account Table to check for new container versions.

The App iterates over rows in the Table where each row provides the URL to list container tag version, the last known version and some filter options to change how the code determines the latest version.

The App downloads the latest list of avaialble tags and then parses them to identify if a newer tag version is available than the version tag stored in the table.

If a newer version tag is identified it sends an email notification.

The App is triggered on a schedule as desired.

The Terraform code deploys the basic Storage Account, Table and Logic App resources but the Logic App will require configuration with integration accounts and connectors for Table storage and SendGrid for sending email notifications.

The Logic App Code is included in the repo.

## Azure Storage Account Table Schema
The following table details the Table schema used to provdie configuration data to the Logic App along with example values.

| Partition Key | Row Key | Timestamp | ContainerTagListURL | LastKnownVersion | TagIgnoreString | TagIncludeString
| --- | --- | --- | --- | --- | --- | --- |
| MicrosoftContainers | speech-to-text | 2023-05-22T11:43:42.1349753Z | https://mcr.microsoft.com/v2/azure-cognitive-services/speechservices/speech-to-text/tags/list | 3.13.0-amd64-en-us | latest | en-us |
| MicrosoftContainers | text-analytics | 2023-05-22T11:43:42.1349753Z | https://mcr.microsoft.com/v2/azure-cognitive-services/textanalytics/language/tags/list | 3.0.73207636-onprem-6447ac22b | latest | |
| MicrosoftContainers | text-translation | 2023-05-22T11:43:42.1349753Z | https://mcr.microsoft.com/v2/azure-cognitive-services/translator/text-translation/tags/list | 1.0.02327.150-amd64 | latest | |
