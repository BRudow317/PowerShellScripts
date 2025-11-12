# Script Policies

# ----Start of file excelHandling-----------------------------------------------------------------


function testExcelHandling {
    Try{
        Throw "Testing Exception Handling"
        # Launch Excel
        $excel = New-Object -ComObject Excel.Application
        $excel.Visible = $true  # Optional

        # Create a new workbook
        $workbook = $excel.Workbooks.Add()

        # Get the first sheet (created by default)
        $sheet1 = $workbook.Sheets.Item(1)
        $sheet1.Name = "Summary"
        $sheet1.Cells.Item(1,1).Value = "sheet1_Summary_Column1"
        $sheet1.Cells.Item(1,2).Value = "sheet1_Summary_ValueB2"
        $sheet1.Cells.Item(2,1).Value = "sheet1_Summary_Column2"
        $sheet1.Cells.Item(2,2).Value = "sheet1_Summary_ValueC2"

        # Add another worksheet
        $sheet2 = $workbook.Sheets.Add()
        $sheet2.Name = "Data"
        $sheet2.Cells.Item(1,1).Value = "sheet2_Data_Column1"
        $sheet2.Cells.Item(2,1).Value = "sheet2_Data_ValueB2"
        $sheet2.Cells.Item(2,1).Value = "sheet2_Data_Column2"
        $sheet2.Cells.Item(2,2).Value = "sheet2_Data_ValueC2"

        # Add a third worksheet
        $sheet3 = $workbook.Sheets.Add()
        $sheet3.Name = "Logs"
        $sheet3.Cells.Item(1,1).Value = "sheet3_Logs_Column1"
        $sheet3.Cells.Item(2,1).Value = "sheet3_Logs_ValueB2"
        $sheet3.Cells.Item(2,1).Value = "sheet3_Logs_Column2"
        $sheet3.Cells.Item(2,2).Value = "sheet3_Logs_ValueC2"

        # Save and quit
        $pathVar = "$home\Downloads\MultiSheetExample.xlsx"
        $workbook.SaveAs($pathVar)
        $excel.Quit()

        Write-Host "Saved workbook with 3 sheets to $pathVar"

        # Read back the workbook and list sheet names
        $excel = New-Object -ComObject Excel.Application
        $workbook = $excel.Workbooks.Open("$pathVar")

        # Loop through all worksheets
        foreach ($sheet in $workbook.Worksheets) {
            Write-Host "Reading from worksheet: $($sheet.Name)"
            $value = $sheet.Cells.Item(1,1).Text
            Write-Host "$value"
        }

        $workbook.Close()
        $excel.Quit()
    }
    Catch{
            Write-Host ($error[0].Exception).GetType().FullName
            Write-Host $(Get-ExceptionDetails -Exception $_ -$ErrorActionPreference SilentlyContinue)
    }
}




# ----End of file excelHandling-----------------------------------------------------------------