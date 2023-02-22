page 50356 "Item Book Series List"
{
    ApplicationArea = All;
    Caption = 'Book Series';
    PageType = List;
    SourceTable = "Item Book Series";
    UsageCategory = Lists;
    CardPageId = "Item Book Series Card";

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
                field("Book Series Name"; Rec."Book Series Name")
                {
                    ToolTip = 'Specifies the value of the Book Series Name field.';
                }

            }
        }
    }
}
