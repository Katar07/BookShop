page 50371 "Item Book Category List"
{
    ApplicationArea = All;
    Caption = 'Book Category';
    PageType = List;
    SourceTable = "Item Book Category";
    CardPageId = "Item Book Category Card";
    UsageCategory = Administration;
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
                }
                field("Category Name"; Rec."Category Name")
                {
                    ToolTip = 'Specifies the value of the Category Name field.';

                }
            }
        }
    }
}
