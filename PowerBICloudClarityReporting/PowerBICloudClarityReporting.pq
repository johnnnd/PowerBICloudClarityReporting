// This file contains your Data Connector logic
section PowerBICloudClarityReporting;

[DataSource.Kind="PowerBICloudClarityReporting", Publish="PowerBICloudClarityReporting.Publish"]
shared PowerBICloudClarityReporting.Contents = (optional message as text) =>    
    let
        accessToken = Text.Format("Bearer {0}", {Extension.CurrentCredential()[access_token]}),
        Source = Json.Document(Web.Contents("https://api.cloudclarity.app/api/powerbireport", [Headers=[#"Content-Type"="application/json",Authorization=accessToken],Content=Text.ToBinary("")]))       
    in
        Source;
    
 
PowerBICloudClarityReporting = [
    Authentication = [
        Aad = [
            AuthorizationUri = "https://login.microsoftonline.com/common/oauth2/authorize",
            Resource = "https://management.azure.com/"]
    ],
   
    Label = Extension.LoadString("DataSourceLabel")
];
 
PowerBICloudClarityReporting.Publish = [
    Beta = true,
    ButtonText = { Extension.LoadString("FormulaTitle"), Extension.LoadString("FormulaHelp") },
    SourceImage = PowerBICloudClarityReporting.Icons,
    SourceTypeImage = PowerBICloudClarityReporting.Icons
];
 
PowerBICloudClarityReporting.Icons = [
    Icon16 = { Extension.Contents("PowerBICloudClarityReporting16.png"), Extension.Contents("PowerBICloudClarityReporting20.png"), Extension.Contents("PowerBICloudClarityReporting24.png"), Extension.Contents("PowerBICloudClarityReporting32.png") },
    Icon32 = { Extension.Contents("PowerBICloudClarityReporting32.png"), Extension.Contents("PowerBICloudClarityReporting40.png"), Extension.Contents("PowerBICloudClarityReporting48.png"), Extension.Contents("PowerBICloudClarityReporting64.png") }
];