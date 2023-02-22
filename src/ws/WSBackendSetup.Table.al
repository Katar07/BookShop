table 50354 "WS Backend Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; PrimaryKey; Code[10])
        {
            Caption = 'Primary Code';
        }
        field(2; "Web Service Base URL"; Text[200])
        {
            Caption = 'Web Service Base URL';
        }
        field(3; "User Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Caption = 'User Name';
        }
        field(4; "Password"; Text[250])
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'User Password';
            ExtendedDatatype = Masked;
        }
        field(5; "Company Id"; Text[100])
        {
            Caption = 'Company Id';

            trigger OnLookup()
            var
                CallWebService: Codeunit "Call Web service";
            begin
                Rec."Company Id" := CopyStr(CallWebService.GetFirstCompanyId(), 1, MaxStrLen(Rec."Company Id"));
            end;
        }
    }

    keys
    {
        key(PK; PrimaryKey)
        {
            Clustered = true;
        }
    }


}