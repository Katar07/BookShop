page 50360 "BookShop RoleCenter"
{
    ApplicationArea = All;
    Caption = 'BookShop';
    PageType = RoleCenter;
    UsageCategory = Lists;

    layout
    {

        area(RoleCenter)
        {
            part(Headline; "Book Shop Headline")
            {

            }
            part(VisualPart; VisualCardPart)
            {
                Caption = 'Navigate';
            }
            part(ShopBookCategory; "Item Book Category ListPart")
            {
                Caption = 'Shop By Book Category';
            }
        }
    }

    actions
    {

        area(Processing)
        {
            action(LogIn)
            {
                Caption = 'Sign In';
                ApplicationArea = All;
                RunObject = codeunit "User Login Management";
                ToolTip = 'Executes the Sign In action.';

            }
            action(LogOut)
            {
                Caption = 'Log Out';
                ApplicationArea = All;
                RunObject = codeunit LogOut;
                ToolTip = 'Executes the Log Out action.';

            }
            action(RegisterNewUser)
            {
                Caption = 'Register New User';
                ApplicationArea = All;
                RunObject = codeunit "User Registration";
                ToolTip = 'Executes the Registartion action.';

            }
        }
    }
}