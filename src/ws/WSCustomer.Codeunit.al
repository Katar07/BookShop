codeunit 50360 "WS Customer"
{
    trigger OnRun()
    var
    begin

    end;

    procedure InsertCustomer(Name: Text[100]): Text
    var
        JsonObject: JsonObject;
        RequestBody: Text;
    begin
        JsonObject.Add('number', '');
        JsonObject.Add('displayName', Name);
        JsonObject.WriteTo(RequestBody);
        exit(
            CallWebService.ExtractFirstValue(
               CallWebService.CallWebService(
               '/companies(' + CallWebService.GetCompanyId() + ')/customers',
                 'POST',
                RequestBody),
                 'number'));
    end;


    var
        CallWebService: Codeunit "Call Web service";

}