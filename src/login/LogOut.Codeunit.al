codeunit 50355 "LogOut"
{
    trigger OnRun()
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        if Confirm('Are you sure you want to logout?', false) then
            UserLoginManagement.LogOut();
    end;
}
