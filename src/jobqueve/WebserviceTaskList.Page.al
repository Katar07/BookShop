page 50376 "Web service Task List"
{
    ApplicationArea = All;
    Caption = 'Web service Task List';
    PageType = List;
    SourceTable = "Web Service Task";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ToolTip = 'Specifies the value of the EntryNo field.';
                }
                field("Task Name"; Rec."Task Name")
                {
                    ToolTip = 'Specifies the value of the Task Name field.';
                }
                field("Primary Key"; Rec."Primary Key")
                {
                    ToolTip = 'Specifies the value of the Primary Key field.';
                }
                // field("Request Body"; Rec."Request Body")
                // {
                //     ToolTip = 'Specifies the value of the Request Body field.';
                // }
                // field("Response Body"; Rec."Response Body")
                // {
                //     ToolTip = 'Specifies the value of the Response Body field.';
                // }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunTask)
            {
                RunObject = Codeunit "Item Web Service Task Run";
                ToolTip = 'Executes the RunTask action.';
                Image = Start;
            }
            action(RunSelectedItem)
            {

                ToolTip = 'Executes the Run Selected action.';
                Image = NextRecord;

                trigger OnAction()
                var
                    WebServiceTask: Codeunit "Item Web Service Task Run";
                begin
                    WebServiceTask.RunTask(Rec);
                end;
            }
            action(RunSelectedCustomer)
            {

                ToolTip = 'Executes the Run Selected action.';
                Image = NextRecord;

                trigger OnAction()
                var
                    WebServiceTask: Codeunit "Customer Web Service Task Run";
                begin
                    WebServiceTask.RunTask(Rec);
                end;
            }
        }
        area(Promoted)
        {
            actionref(StartTask; RunTask)
            {

            }

        }
    }
}
