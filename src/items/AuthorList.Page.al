page 50352 "AuthorList"
{
    ApplicationArea = All;
    Caption = 'Authors';
    PageType = List;
    SourceTable = Author;
    UsageCategory = Lists;
    CardPageId = "Author Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
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
