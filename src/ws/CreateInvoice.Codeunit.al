codeunit 50353 "Create Invoice"
{
    TableNo = Cart;

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        UserLogin: Record "UserLogin";
        WSCreateInvoice: Codeunit "WSCreate Invoice";
        UserLoginManagement: Codeunit "User Login Management";
        SalesInvoiceMsg: Label 'Invoice was successfully completed!';
        BackSalesInvoiceId: Text;
    begin
        System.WorkDate(Today());
        UserLogin.Get(UserLoginManagement.GetCurrentUserLogin()."User ID");

        SalesHeader := CreateSalesHeader(Rec);
        CreateSalesLines(SalesHeader, Rec);

        BackSalesInvoiceId := WSCreateInvoice.CreateSalesHeader(UserLogin."Backend Customer No.");
        CreateBackendSalesLines(BackSalesInvoiceId, Rec);

        Rec."Backend Sales Invoice No" := CopyStr(WSCreateInvoice.GetSalesInvoice(BackSalesInvoiceId), 1, MaxStrLen(Rec."Backend Sales Invoice No"));
        Rec.Modify(true);

        WSCreateInvoice.PostDocument(BackSalesInvoiceId);
        PostDocument(SalesHeader);

        Message(SalesInvoiceMsg);

        DeleteCartLines(Rec);
    end;

    local procedure CreateSalesHeader(Cart: Record "Cart"): Record "Sales Header"
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
    begin
        Customer.Get(Cart."Customer No");

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."No." := '';
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", Customer."No.");

        SalesHeader.Modify(true);
        exit(SalesHeader);
    end;

    local procedure CreateSalesLines(SalesHeader: Record "Sales Header"; Cart: Record Cart)
    var
        CartLine: Record "Cart Line";
        LineNo: Integer;
    begin

        CartLine.SetRange("Cart No.", Cart."No.");
        if CartLine.FindSet() then
            repeat
                LineNo += 10000;
                CreateSalesLine(SalesHeader, CartLine, LineNo);
            until CartLine.Next() = 0;
    end;

    local procedure CreateSalesLine(SalesHeader: Record "Sales Header"; CartLine: Record "Cart Line"; LineNo: Integer)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := LineNo;
        SalesLine.Insert(true);

        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", CartLine."Item No.");
        SalesLine.Validate(Quantity, CartLine.Quantity);
        SalesLine.Validate("Unit Price", CartLine.UnitPrice);
        SalesLine.Validate("Amount", CartLine.Amount);
        SalesLine.Validate(Quantity, CartLine.Quantity);
        SalesLine.Modify();
    end;

    local procedure PostDocument(SalesHeader: Record "Sales Header")
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        SalesPost.Run(SalesHeader);
    end;

    procedure DeleteCartLines(Cart: Record Cart)
    var
        CartLine: Record "Cart Line";
    begin
        CartLine.SetRange("Cart No.", Cart."No.");
        CartLine.DeleteAll();
    end;

    local procedure CreateBackendSalesLines(BackSalesInvoiceId: Text; Cart: Record "Cart")
    var
        CartLine: Record "Cart Line";
        Item: Record Item;
        WSCreateInvoice: Codeunit "WSCreate Invoice";

    begin
        CartLine.SetRange("Cart No.", Cart."No.");
        if CartLine.FindSet() then
            repeat
                Item.Get(CartLine."Item No.");
                WSCreateInvoice.CreateSalesLine(BackSalesInvoiceId, Item."Backend BookItem ID", CartLine.Quantity, CartLine.UnitPrice);
            until CartLine.Next() = 0;
    end;
}
