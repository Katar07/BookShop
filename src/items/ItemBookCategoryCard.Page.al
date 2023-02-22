page 50354 "Item Book Category Card"
{
    ApplicationArea = All;
    Caption = 'Book Category Card';
    PageType = Card;
    SourceTable = "Item Book Category";
    UsageCategory = Lists;


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
                field("Category Name"; Rec."Category Name")
                {
                    ToolTip = 'Specifies the value of the Category Name field.';
                }
            }
        }
    }
}
