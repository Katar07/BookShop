table 50357 "UserLogin"
{
    Caption = 'User Login';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User Id"; Integer)
        {
            Caption = 'User Id';
            AutoIncrement = true;

        }
        field(2; "User Name"; Text[50])
        {
            Caption = 'UserName';
        }
        field(3; Password; Text[100])
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'Password';
            ExtendedDatatype = Masked;
        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(5; "Backend Customer No."; Code[20])
        {
            Caption = 'Backend Customer No.';
        }
    }
    keys
    {
        key(PK; "User Id")
        {
            Clustered = true;
        }
    }

    procedure CheckPassword()
    begin
        TestField(Password);
        if StrLen(Password) < 5 then
            FieldError(Password, 'cannot be less than 5 characters long');
    end;

}
