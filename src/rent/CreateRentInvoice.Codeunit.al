codeunit 50364 "Create Rent Invoice"
{
    TableNo = "Rent Cart";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        UserLogin: Record "UserLogin";
        UserLoginManagement: Codeunit "User Login Management";
        SalesInvoiceMsg: Label 'Process of Renting Books was successfully completed!';

    begin
        System.WorkDate(Today());
        UserLogin.Get(UserLoginManagement.GetCurrentUserLogin()."User ID");

        SalesHeader := CreateSalesHeader(Rec);
        CreateSalesLines(SalesHeader, Rec);

        PostDocument(SalesHeader);

        Message(SalesInvoiceMsg);
        DeleteCartLines(Rec);
    end;

    local procedure CreateSalesHeader(RentCart: Record "Rent Cart"): Record "Sales Header"
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
    begin
        Customer.Get(RentCart."Customer No");

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := '';
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", Customer."No.");
        SalesHeader.Modify(true);
        exit(SalesHeader);
    end;

    local procedure CreateSalesLines(SalesHeader: Record "Sales Header"; RentCart: Record "Rent Cart")
    var
        RentCartLine: Record "Rent Cart Line";
        LineNo: Integer;
    begin
        RentCartLine.SetRange("Rent Cart No.", RentCart."No.");
        if RentCartLine.FindSet() then
            repeat
                LineNo += 10000;
                CreateSalesLine(SalesHeader, RentCartLine, LineNo);
            until RentCartLine.Next() = 0;
    end;

    local procedure CreateSalesLine(SalesHeader: Record "Sales Header"; RentCartLine: Record "Rent Cart Line"; LineNo: Integer)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := LineNo;
        SalesLine.Insert(true);

        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", RentCartLine."Item No.");
        SalesLine.Validate(Quantity, RentCartLine.Quantity);

        SalesLine.Validate("Unit Price", 0);
        SalesLine.Modify();
    end;

    local procedure PostDocument(SalesHeader: Record "Sales Header")
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Run(SalesHeader);
    end;

    procedure DeleteCartLines(RentCart: Record "Rent Cart")
    var
        RentCartLine: Record "Rent Cart Line";
    begin
        RentCartLine.SetRange("Rent Cart No.", RentCart."No.");
        RentCartLine.DeleteAll();
    end;

}
