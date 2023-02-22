page 50351 "Author Card"
{
    ApplicationArea = All;
    Caption = 'Author Card';
    PageType = Card;
    SourceTable = Author;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("No of Books"; Rec."No of Books")
                {
                    ToolTip = 'Specifies the value of the No of Books field.';
                }
            }
        }
    }
}
