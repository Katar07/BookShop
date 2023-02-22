page 50380 "Return Cart Line"
{
    ApplicationArea = All;
    Caption = 'Return Cart Lines';
    PageType = ListPart;
    SourceTable = "Return Cart Line";
    AutoSplitKey = true;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Return Cart No."; Rec."Return Cart No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cart No. field.';
                }
                field("Return Line No."; Rec."Return Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Return Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';

                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field(DuDate; Rec.DueDate)
                {
                    ToolTip = 'Specifies the value of the DueDate field.';
                }
                field(PriceForOverdue; Rec."Price For Overdue")
                {
                    ToolTip = 'Specifies Last day to return Books, 30 days after renting Books!';

                }
                field(UnitPrice; Rec.ReturnUnitPrice)
                {
                    ToolTip = 'Specifies the value of the UnitPrice field.';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec."Price For Overdue" := 2;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CheckQuantity();
    end;


    local procedure CheckQuantity()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        UserLoginManagement: Codeunit "User Login Management";
        RefQuantity: Decimal;
    begin
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SetRange("Source No.", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
        ItemLedgerEntry.SetRange("Sales Amount (Actual)", 0);
        ItemLedgerEntry.SetRange(Open, false);
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
        ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
        if ItemLedgerEntry.FindFirst() then begin
            RefQuantity := ItemLedgerEntry.Quantity;
            If Rec.Quantity <= 0 then
                Error('Quantity must be 1 or bigger!')
            else
                if Rec.Quantity > (RefQuantity - (RefQuantity + RefQuantity))
           then
                    Error('Quantity cannot be bigger than Rent Quantity!');
        end
    end;

}
