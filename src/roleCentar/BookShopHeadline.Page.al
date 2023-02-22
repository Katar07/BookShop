page 50367 "Book Shop Headline"
{
    PageType = HeadlinePart;
    ApplicationArea = All;
    Caption = 'Book Shop Headline';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            field(CheckUser; CheckUserStatus())
            {
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"User Login Management");
                end;

            }
            field(BuyNewBook; 'Buy new Book')
            {
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    Item: Record Item;
                begin
                    Item.SetFilter("Item Category Code", 'BOOKS');
                    Page.Run(Page::"Item List", Item);
                end;
            }
            field(RentBooks; 'Rent Books')
            {
                ApplicationArea = All;

                trigger OnDrillDown()
                var
                    Item: Record Item;
                begin
                    Item.SetFilter("Item Category Code", 'BOOKS');
                    Page.Run(Page::"Item List", Item);
                end;

            }
        }
    }

    procedure CheckUserStatus(): Text
    var
        UserLogInManagement: Codeunit "User Login Management";
        NoUserLbl: Label '<payload>Please Sign In before shopping.</payload>';
        WelcomeTxtLbl: Label '<payload><emphasize> Welcome to our BookShop %1!</emphasize></payload>', Comment = '%1 is uer name';
    begin
        if UserLogInManagement.IsUserLogged() then
            exit(StrSubstNo(WelcomeTxtLbl, UserLogInManagement.GetCurrentUserLogin()."User Name"))
        else
            exit(NoUserLbl);
    end;
}