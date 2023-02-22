codeunit 50359 "WS Item"
{
    TableNo = Item;
    trigger OnRun()
    begin

        if Rec."Backend BookItem ID" = '' then
            Rec."Backend BookItem ID" := CopyStr(InsertItem(Rec), 1, MaxStrLen(Rec."Backend BookItem ID"));
        Message('Item with number %1 has been created.', Rec."Backend BookItem ID");
    end;

    procedure InsertItem(Item: Record Item): Text
    var
        RequestBody: Text;
        JsonObject: JsonObject;
    begin
        JsonObject.Add('displayName', Item.Description);
        JsonObject.Add('type', 'Inventory');
        JsonObject.Add('itemCategoryCode', Item."Item Category Code");
        JsonObject.Add('unitPrice', Item."Unit Price");
        JsonObject.Add('baseUnitOfMeasureCode', 'PCS');
        JsonObject.WriteTo(RequestBody);
        exit(
            CallWebService.ExtractFirstValue(
                CallWebService.CallWebService(
                    '/companies(' + CallWebService.GetCompanyId() + ')/items',
                         'POST',
                        RequestBody),
                'number'));
    end;

    var
        CallWebService: Codeunit "Call Web service";
}