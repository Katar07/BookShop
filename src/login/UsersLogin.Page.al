page 50369 "UsersLogin"
{
    ApplicationArea = All;
    Caption = 'User Log In List';
    PageType = List;
    SourceTable = "UserLogin";
    UsageCategory = Administration;
    CardPageId = "UserLogin Card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("User Id"; Rec."User Id")
                {
                    ToolTip = 'Specifies the value of the UserId field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the UserName field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Password field.';
                }
                field("Back No"; Rec."Backend Customer No.")
                {
                    ToolTip = 'Specifies the value of the Backend Customer No. field.';

                }
            }
        }
    }
}
