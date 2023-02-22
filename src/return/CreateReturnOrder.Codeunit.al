codeunit 50365 "Create Return Order"
{
    TableNo = "Return Cart";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        UserLogin: Record "UserLogin";
        UserLoginManagement: Codeunit "User Login Management";
        SalesInvoiceMsg: Label 'Return process was successfully completed!';

    begin
        System.WorkDate(Today());
        UserLogin.Get(UserLoginManagement.GetCurrentUserLogin()."User ID");

        SalesHeader := CreateSalesHeader(Rec);
        CreateSalesLines(SalesHeader, Rec);

        PostDocument(SalesHeader);

        Message(SalesInvoiceMsg);

        DeleteCartLines(Rec);
    end;

    local procedure CreateSalesHeader(ReturnCart: Record "Return Cart"): Record "Sales Header"
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
    begin
        Customer.Get(ReturnCart."Customer No");

        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::"Return Order";
        SalesHeader."No." := '';
        SalesHeader.Insert(true);

        SalesHeader.Validate("Sell-to Customer No.", Customer."No.");


        SalesHeader.Modify(true);
        exit(SalesHeader);
    end;

    local procedure CreateSalesLines(SalesHeader: Record "Sales Header"; ReturnCart: Record "Return Cart")
    var
        ReturnCartLine: Record "Return Cart Line";
        LineNo: Integer;
    begin

        ReturnCartLine.SetRange("Return Cart No.", ReturnCart."No.");
        if ReturnCartLine.FindSet() then
            LineNo := 10000;
        repeat
            LineNo += 10000;
            CreateSalesLine(SalesHeader, ReturnCartLine, LineNo);
        until ReturnCartLine.Next() = 0;
    end;

    local procedure CreateSalesLine(SalesHeader: Record "Sales Header"; ReturnCartLine: Record "Return Cart Line"; LineNo: Integer)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := LineNo;
        SalesLine.Insert(true);

        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", ReturnCartLine."Item No.");
        SalesLine.Validate(Quantity, ReturnCartLine.Quantity);
        SalesLine.Validate("Unit Price", ReturnCartLine.ReturnUnitPrice);
        SalesLine.Validate("Amount", ReturnCartLine.Amount);

        SalesLine.Modify();
    end;


    local procedure PostDocument(SalesHeader: Record "Sales Header")
    var
        SalesPostYesNo: Codeunit "Sales-Post (Yes/No)";
    begin
        SalesPostYesNo.Run(SalesHeader);
    end;

    procedure DeleteCartLines(ReturnCart: Record "Return Cart")
    var
        ReturnCartLine: Record "Return Cart Line";
    begin
        ReturnCartLine.SetRange("Return Cart No.", ReturnCart."No.");
        ReturnCartLine.DeleteAll();
    end;


    // local procedure CreateSalesLineCharge(ReturnCart: Record "Return Cart"; SalesHeader: Record "Sales Header"; ReturnCartLine: Record "Return Cart Line"; LineNo: Integer)
    //     var
    //         SalesLine: Record "Sales Line";
    //     begin
    //         SalesLine.Init();
    //         SalesLine."Document Type" := SalesHeader."Document Type";
    //         SalesLine."Document No." := SalesHeader."No.";
    //         SalesLine."Line No." := LineNo;
    //         SalesLine.Modify(true);

    //         SalesLine.Validate(Type, SalesLine.Type::"Charge (Item)");
    //         SalesLine.Validate("No.", 'S-ALLOWANCE');
    //         SalesLine.Validate(Quantity, ReturnCart.TotalQuantity);
    //         SalesLine.Validate("Unit Price", ReturnCartLine.ReturnUnitPrice);
    //         SalesLine.Validate("Amount", ReturnCart.TotalAmount);

    //         SalesLine.Validate("Allow Item Charge Assignment", true);
    //         SalesLine.Validate("Qty. to Invoice (Base)", ReturnCart.TotalQuantity);
    //         SalesLine.Validate("Qty. to Invoice", 1);
    //         SalesLine.Validate("Qty. to Assign", 1);

    //         SalesLine.Validate("Unit Price", 2);


    //         SalesLine.Modify();
    //     end;



}
