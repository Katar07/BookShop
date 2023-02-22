page 50374 "Rent Cart Line"
{
    ApplicationArea = All;
    Caption = 'Rent Cart Lines';
    PageType = ListPart;
    SourceTable = "Rent Cart Line";
    AutoSplitKey = true;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Rent Cart No."; Rec."Rent Cart No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Cart No. field.';
                }
                field("Rent Line No."; Rec."Rent Line No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Item No."; Rec."Item No.")
                {
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
            }
        }
    }
}
