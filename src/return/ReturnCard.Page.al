page 50379 "Return Card"
{
    ApplicationArea = All;
    Caption = 'Return Card';
    PageType = Document;
    SourceTable = "Return Cart";
    RefreshOnActivate = true;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field("Customer No"; Rec."Customer No")
                {
                    ToolTip = 'Specifies the value of the Customer field.';
                    Visible = false;
                }
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies the value of the Default field.';
                    Visible = false;
                }

                field("TotalQuantity"; Rec.TotalQuantity)
                {
                    ToolTip = 'Specifies the value of the Total Quantity field.';
                }
                field("Total Amount"; Rec.TotalAmount)
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }


            }
            part(Lines; "Return Cart Line")
            {
                SubPageLink = "Return Cart No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(FindEntries)
            {
                ApplicationArea = All;
                Caption = 'Find My Rent Books';
                Image = Payment;
                ToolTip = 'Executes the Find My Rent Books action.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;


                trigger OnAction()
                var
                    ReturnCartNo: Code[20];
                begin
                    ReturnCartNo := SelectCart();
                    CreateLine(ReturnCartNo);
                    CurrPage.Update();
                end;
            }
            action(Return)
            {
                ApplicationArea = All;
                Caption = 'Return Books in Cart';
                Image = Payment;
                ToolTip = 'Executes the Return  action.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = codeunit "Create Return Order";
            }


        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.TotalAmount := Rec.TotalCartAmount();
        Rec.TotalQuantity := Rec.TotalCartQuantity();
    end;

    local procedure CreateLine(ReturnCartNo: Code[20])
    var
        Item: Record Item;
        ItemLedgerEntry: Record "Item Ledger Entry";
        ReturnCartLine: Record "Return Cart Line";
        UserLoginManagement: Codeunit "User Login Management";
        Duedate: Date;
        RefDate: Text;
        Today: Date;
    begin
        RefDate := '<CD+30D>';
        Today := Today();
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SetRange("Source No.", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
        ItemLedgerEntry.SetRange("Sales Amount (Actual)", 0);
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
        ItemLedgerEntry.SetRange(Open, false);

        if ItemLedgerEntry.FindSet() then
            repeat
                ReturnCartLine.Init();
                ReturnCartline."Return Cart No." := ReturnCartNo;
                ReturnCartline."Return Line No." := GetLastCartLineNo(ReturnCartNo) + 10000;
                ReturnCartLine."Item No." := ItemLedgerEntry."Item No.";
                ReturnCartLine.Quantity := ItemLedgerEntry.Quantity;


                Item.SetRange("No.", ReturnCartLine."Item No.");
                if Item.FindFirst() then
                    ReturnCartLine.Description := Item.Description;
                Duedate := CalcDate(RefDate, ItemLedgerEntry."Posting Date");
                ReturnCartLine.DueDate := Duedate;
                if Today() = Duedate then
                    ReturnCartLine.ReturnUnitPrice := (Today() - Duedate) * 2
                else
                    ReturnCartLine.ReturnUnitPrice := 0;
                ReturnCartLine.Amount := ReturnCartLine.Quantity * ReturnCartLine.ReturnUnitPrice;

                ReturnCartLine.Insert(true);
            until ItemLedgerEntry.Next() = 0;
    end;


    local procedure GetLastCartLineNo(ReturnCartNo: Code[20]): Integer
    var
        ReturnCartLine: Record "Return Cart Line";
    begin
        ReturnCartLine.SetRange("Return Cart No.", ReturnCartNo);
        if ReturnCartLine.FindLast() then
            exit(ReturnCartLine."Return Line No.")
    end;


    local procedure SelectCart(): Code[20]
    var
        ReturnCart: Record "Return Cart";
        UserLoginManagement: Codeunit "User Login Management";
        CustomerNo: Code[20];
    begin
        CustomerNo := UserLoginManagement.GetCurrentUserLogin()."Customer No.";
        if not ReturnCart.FindMyDefault() then begin
            ReturnCart.Init();
            ReturnCart."No." := 'DEFAULT';
            ReturnCart.Description := 'My default cart';
            ReturnCart."Customer No" := CustomerNo;
            ReturnCart.Insert(true);
        end;
        exit(ReturnCart."No.");
    end;

    trigger OnDeleteRecord(): Boolean
    var
        DeleteCartLine: Codeunit "Create Return Order";
    begin
        DeleteCartLine.DeleteCartLines(Rec);
    end;
}
