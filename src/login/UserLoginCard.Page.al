page 50368 "UserLogin Card"
{
    ApplicationArea = All;
    Caption = 'Authorization';
    PageType = Card;
    SourceTable = "UserLogin";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(Authorization)
            {
                Caption = 'Please enter User Name and Password!';
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the UserName field.';
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.';
                }
            }
        }
    }
}
