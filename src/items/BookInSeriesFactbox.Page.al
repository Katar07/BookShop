page 50370 "Book In Series Factbox"
{
    ApplicationArea = All;
    Caption = 'Book In Series';
    PageType = ListPart;
    SourceTable = "Item";
    CardPageId = "Item Book Category Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    Caption = 'Book Name';
                    ToolTip = 'Specifies the value of the Description field.';
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Item.SetRange(Item."No.", Rec."No.");
                        Page.Run(Page::"Item Card", Item);
                    end;
                }
            }
        }
    }
}
