codeunit 50358 "WSCreate Invoice"
{
    TableNo = Cart;
    trigger OnRun()
    var
    begin

    end;

    procedure CreateSalesHeader(BackendCustomerNo: Code[20]): Text
    var
        JsonObject: JsonObject;
        RequestBody: Text;
    begin
        JsonObject.Add('CustomerNumber', BackendCustomerNo);
        JsonObject.WriteTo(RequestBody);
        exit(
            CallWebService.ExtractFirstValue(
                CallWebService.CallWebService(
                    '/companies(' + CallWebService.GetCompanyId() + ')/salesInvoices',
                         'POST',
                        RequestBody),
                'id'));
    end;

    procedure CreateSalesLine(SalesInvoiceId: Text; BackendItemNo: Code[20]; Quantity: Integer; UnitPrice: Decimal): Text
    var
        JsonObject: JsonObject;
        RequestBody: Text;
    begin

        JsonObject.Add('lineType', 'Item');
        JsonObject.Add('lineObjectNumber', BackendItemNo);
        JsonObject.Add('quantity', Quantity);
        JsonObject.Add('unitPrice', UnitPrice);
        JsonObject.WriteTo(RequestBody);
        exit(
            CallWebService.ExtractFirstValue(
                CallWebService.CallWebService(
                    '/companies(' + CallWebService.GetCompanyId() + ')/salesInvoices(' + SalesInvoiceId + ')/salesInvoiceLines',
                         'POST',
                        RequestBody),
                'id'));
    end;

    procedure GetSalesInvoice(SalesInvoiceId: Text): Text
    var

    begin
        exit(
            CallWebService.ExtractFirstValue(
                CallWebService.CallWebService(
                    '/companies(' + CallWebService.GetCompanyId() + ')/salesInvoices(' + SalesInvoiceId + ')',
                         'GET',
                        ''),
                'number'));
    end;


    procedure PostDocument(SalesHeaderId: Text)
    var
        RequestBody: Text;
    begin

        CallWebService.CallWebService(
        '/companies(' + CallWebService.GetCompanyId() + ')/salesInvoices(' + SalesHeaderId + ')/Microsoft.NAV.post',
          'POST',
         RequestBody);

    end;


    var
        CallWebService: Codeunit "Call Web service";
}