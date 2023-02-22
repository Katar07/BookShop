codeunit 50356 "User Registration"
{
    trigger OnRun()
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        UserLoginManagement.UserRegistration();
    end;
}
