codeunit 50350 "Call Web service"
{
    procedure GetBaseURL(): Text
    var
        WSBackendSetup: Record "WS Backend Setup";
        APITokLbl: Label '/api/v2.0', Locked = true, Comment = 'API of Web service URL';
    begin
        WSBackendSetup.Get();
        WSBackendSetup.TestField("Web Service Base URL");
        exit(WSBackendSetup."Web Service Base URL" + APITokLbl);

    end;

    local procedure GetAuthorization(): Text
    var
        WSBackendSetup: Record "WS Backend Setup";
        Base64Convert: Codeunit "Base64 Convert";
    begin
        WSBackendSetup.Get();
        WSBackendSetup.TestField("User Name");
        WSBackendSetup.TestField(Password);
        exit(Base64Convert.ToBase64(WSBackendSetup."User Name" + ':' + WSBackendSetup.Password));
    end;

    procedure GetCompanyId(): Text
    var
        WSBackendSetup: Record "WS Backend Setup";
    begin
        WSBackendSetup.Get();
        WSBackendSetup.TestField("Company Id");
        exit(WSBackendSetup."Company Id");
    end;


    procedure GetFirstCompanyId(): Text
    begin
        exit(
             ExtractFirstValue(
                 CallWebService(
                     '/companies',
                     'GET',
                     ''),
                 'id')
        );
    end;


    procedure WebServiceGet(api: Text; var HttpResponseMessage: HttpResponseMessage)
    var
        HttpClient: HttpClient;
        HttpHeaders: HttpHeaders;
    begin
        HttpHeaders := HttpClient.DefaultRequestHeaders();
        HttpHeaders.Add('Authorization', 'Basic ' + GetAuthorization());
        HttpClient.Get(GetBaseURL() + api, HttpResponseMessage);
    end;

    procedure CallWebService(api: Text; method: Text; RequestBody: Text): HttpResponseMessage
    var
        HttpClient: HttpClient;
        HttpHeaders: HttpHeaders;
        HttpRequestMessage: HttpRequestMessage;
        HttpContent: HttpContent;
        HttpResponseMessage: HttpResponseMessage;
    begin
        //Patch Method
        HttpRequestMessage.SetRequestUri(GetBaseURL() + api);
        HttpRequestMessage.Method(method);

        if (RequestBody <> '') then begin
            //Request Body
            HttpContent.WriteFrom(RequestBody);
            //Request Header
            HttpContent.GetHeaders(HttpHeaders);
            HttpHeaders.Clear();
            // ili
            // HttpHeaders.Remove('Content-type');
            HttpHeaders.Add('Content-type', 'application/json');
            HttpRequestMessage.Content := HttpContent;
        end;
        //Authorization
        HttpHeaders := HttpClient.DefaultRequestHeaders();
        HttpHeaders.Add('Authorization', 'Basic ' + GetAuthorization());
        HttpHeaders.Add('If-Match', '*');
        //Call web service
        HttpClient.Send(HttpRequestMessage, HttpResponseMessage);

        if not HttpResponseMessage.IsSuccessStatusCode() then
            Error('%1: %2', HttpResponseMessage.HttpStatusCode, HttpResponseMessage.ReasonPhrase)
        else
            exit(HttpResponseMessage);

    end;


    procedure ExtractFirstValue(HttpResponseMessage: HttpResponseMessage; JsonKey: Text): Text
    var
        HttpContent: HttpContent;
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        JsonArray: JsonArray;
        JsonValue: JsonValue;
        OutputString: Text;
    begin
        HttpContent := HttpResponseMessage.Content();
        HttpContent.ReadAs(OutputString);
        JsonObject.ReadFrom(OutputString);
        if JsonObject.Get('value', JsonToken) then begin
            JsonArray := JsonToken.AsArray();
            JsonArray.Get(0, JsonToken);
            JsonObject := JsonToken.AsObject()
        end;
        JsonObject.Get(JsonKey, JsonToken);
        JsonValue := JsonToken.AsValue();
        exit(JsonValue.AsText());
    end;

}