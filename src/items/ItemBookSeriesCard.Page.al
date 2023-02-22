page 50357 "Item Book Series Card"
{
    ApplicationArea = All;
    Caption = 'Book Series';
    PageType = Card;
    SourceTable = "Item Book Series";
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
                field("Book Series Name"; Rec."Book Series Name")
                {
                    ToolTip = 'Specifies the value of the Book Series Name field.';
                }

            }
        }
    }
}
