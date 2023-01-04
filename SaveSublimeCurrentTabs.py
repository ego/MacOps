# Save all Tabs file path
# View/Show Console and enter commands:
import datetime;
import pathlib;
name = datetime.datetime.now().strftime('%Y-%m-%d-%H');
tabs = list(filter(None, [v.file_name() for v in window.views()]));
home = str(pathlib.Path.home());
f = open(f"{home}/Workspaces/Sublime/Tabs/{name}.txt", "w");
f.write("\n".join(tabs));
f.close();
