Config = {}

--SERVER SETTINGS
Config.Framework = "ESX" -- Set your framework! qbcore, ESX, standalone
Config.NotificationType = "ox_lib" -- ESX, ox_lib, qbcore
Config.Progress = "ox" -- progressBars, ox, qbcore

--Police jobs
Config.PoliceJobs = {
    police = {
        Shortcut = "LSPD",
        Grades = {
            { GradeNumber = 0, Shortcut = "CADET" },
        }
    }
}
