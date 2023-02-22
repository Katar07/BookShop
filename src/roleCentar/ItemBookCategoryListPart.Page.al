page 50353 "Item Book Category ListPart"
{
    ApplicationArea = All;
    Caption = 'Book Category';
    PageType = ListPart;
    SourceTable = "Item Book Category";
    CardPageId = "Item Book Category Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Visible = false;
                }
                field("Category Name"; Rec."Category Name")
                {

                    ToolTip = 'Specifies the value of the Category Name field.';
                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Item.SetRange("Book Category Name", Rec."Category Name");
                        Page.Run(Page::"Item List", Item);
                    end;
                }
            }
            cuegroup("CueGroup")
            {

            }
        }
    }
}
