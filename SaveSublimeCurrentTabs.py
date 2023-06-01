# Save all open `Tabs` into file.
# Open Sublime go to View/Show Console and enter commands:
import datetime;
import pathlib;
name = datetime.datetime.now().strftime('%Y-%m-%d-%H');
tabs = list(filter(None, [v.file_name() for v in window.views()]));
home = str(pathlib.Path.home());
f = open(str(pathlib.Path(f"{home}/Workspaces/Sublime/Tabs/{name}.txt")), "w");
f.write("\n".join(tabs));
f.close();
