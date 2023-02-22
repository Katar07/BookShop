table 50360 "VisualTableSetup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';

        }
        field(2; Media1; Media)
        {
            Caption = 'Media1';

        }
        field(3; Media2; Media)
        {
            Caption = 'Media2';

        }
        field(4; Media3; Media)
        {
            Caption = 'Media3';

        }
        field(5; Media4; Media)
        {
            Caption = 'Media4';

        }
        field(6; Media5; Media)
        {
            Caption = 'Media5';

        }
        field(7; Media6; Media)
        {
            Caption = 'Media6';

        }
    }

    keys
    {
        key(Key1; code)
        {
            Clustered = true;
        }
    }





}