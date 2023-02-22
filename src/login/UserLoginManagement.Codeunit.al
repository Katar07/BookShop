codeunit 50354 "User Login Management"
{
    TableNo = "UserLogin";
    SingleInstance = true;

    trigger OnRun()
    begin
        Login();
    end;

    procedure Login()
    var
        TempUserLogin: Record "UserLogin" temporary;
        UserLogin: Record "UserLogin";
    begin
        TempUserLogin.Init();
        TempUserLogin.Insert(false);
        if Page.RunModal(Page::"UserLogin Card", TempUserLogin) = Action::LookupOK then begin
            UserLogin.SetFilter("User Name", '@' + TempUserLogin."User Name");
            UserLogin.FindFirst();

            if not (UserLogin.Password = TempUserLogin.Password) then
                Error('Password does not match the username!');

        end;
        SetCurrentLoginUser(UserLogin);

    end;

    procedure UserRegistration(): Code[20]
    var
        TempUserLogin: Record "UserLogin" temporary;
        UserLogin: Record "UserLogin";

    begin
        TempUserLogin.Init();
        TempUserLogin.Insert(false);
        if Page.RunModal(Page::"UserLogin Card", TempUserLogin) = Action::LookupOK then begin
            UserLogin.SetFilter("User Name", '@' + TempUserLogin."User Name");
            if UserLogin.FindFirst() then
                Error('This user already exist!');
            TempUserLogin.CheckPassword();
            UserLogin.Init();
            UserLogin.TransferFields(TempUserLogin);
            UserLogin."User Id" := 0;
            UserLogin."Customer No." := CreateNewCustomer(TempUserLogin);
            UserLogin."Backend Customer No." := TempUserLogin."Backend Customer No.";
            UserLogin.Insert(true);
            SetCurrentLoginUser(UserLogin);
        end;

    end;


    procedure LogOut()
    begin
        Clear(CurrentUserLogin);
    end;


    procedure SetCurrentLoginUser(NewUserLogin: Record "UserLogin")
    begin
        CurrentUserLogin := NewUserLogin;
    end;

    procedure GetCurrentUserLogin(): Record "UserLogin"
    begin
        exit(CurrentUserLogin);
    end;

    procedure IsUserLogged(): Boolean
    begin
        exit(CurrentUserLogin."User Name" <> '');
    end;

    local procedure CreateNewCustomer(var TempUserLogin: Record "UserLogin" temporary): Code[20]
    var
        Customer: Record "Customer";
        WSCustomer: Codeunit "WS Customer";
    begin
        Customer.Init();
        Customer.Name := TempUserLogin."User Name";
        Customer."Gen. Bus. Posting Group" := 'DOMESTIC';
        Customer."Customer Posting Group" := 'DOMESTIC';
        Customer."VAT Bus. Posting Group" := 'DOMESTIC';
        Customer."Prices Including VAT" := true;
        Customer.Insert(true);
        TempUserLogin."Backend Customer No." := CopyStr(WSCustomer.InsertCustomer(Customer.Name), 1, MaxStrLen(TempUserLogin."Backend Customer No."));
        exit(Customer."No.");
    end;

    var
        CurrentUserLogin: Record "UserLogin";

}