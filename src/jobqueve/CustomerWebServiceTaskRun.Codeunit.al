codeunit 50361 "Customer Web Service Task Run"
{

    trigger OnRun()
    var
        WebServiceTask: Record "Web Service Task";
    begin
        WebServiceTask.SetFilter(Status, '''''');
        if WebServiceTask.FindSet(true) then
            repeat
                RunTask(WebServiceTask);
            until WebServiceTask.Next() = 0;
    end;

    procedure RunTask(WebServiceTask: Record "Web Service Task")
    begin
        if not TryRunTask(WebServiceTask) then begin
            WebServiceTask.Status := CopyStr(System.GetLastErrorText(), 1, MaxStrLen(WebServiceTask.Status));
            WebServiceTask.Modify(true);
        end else begin
            WebServiceTask.Status := '200 Ok.';
            WebServiceTask.Modify(true);
        end;
    end;

    [TryFunction]
    local procedure TryRunTask(WebServiceTask: Record "Web Service Task")
    var
        Customer: Record Customer;
        WSCustomer: Codeunit "WS Customer";
    begin
        Customer.Get(WebServiceTask."Primary Key");
        WSCustomer.InsertCustomer(Customer.Name);
    end;
}
