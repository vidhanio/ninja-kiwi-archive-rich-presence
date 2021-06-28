from pypresence import Presence
import json, pprint, configparser, time, psutil, sys
import pygetwindow as gw
import os

class rich_presence:
    def __init__(self):
        self.config = configparser.ConfigParser()
        self.config.read("config.ini")
        self.assets = json.load(open("assets.json", "r"))
        self.client_id = self.config["Rich Presence"]["client_id"]
        self.RPC = Presence(self.client_id)
        self.RPC.connect()
        self.previous_format_dict = {}
        self.previous_format_dict["start"] = time.time()
        while True:
            if (
                "Ninja Kiwi Archive.exe" in (p.name() for p in psutil.process_iter())
            ) and (sys.platform.startswith("win32")):
                pvars = self.presence_gen(self.format_gen())
                # print("-------------------------\npresence_dict\n-------------------------")
                # pprint.pprint(pvars)
                self.RPC.update(
                    large_image=pvars["large_image"],
                    large_text=pvars["large_text"],
                    small_image=pvars["small_image"],
                    small_text=pvars["small_text"],
                    details=pvars["details"],
                    state=pvars["state"],
                    start=pvars["start"],
                )
                pprint.pprint(pvars)
                print("--------------------")
            elif sys.platform.startswith("win32"):
                print("Ninja Kiwi Archive is not running")
                self.RPC.clear()
                if close_on_close:
                    exit()
            else:
                pvars = self.presence_gen(self.format_gen)
                # print("-------------------------\npresence_dict\n-------------------------")
                # pprint.pprint(pvars)
                self.RPC.update(
                    large_image=pvars["large_image"],
                    large_text=pvars["large_text"],
                    small_image=pvars["small_image"],
                    small_text=pvars["small_text"],
                    details=pvars["details"],
                    state=pvars["state"],
                    start=pvars["start"],
                )
                pprint.pprint(pvars)
                print("--------------------")
            time.sleep(15)

    def format_gen(self):
        self.format_dict = {
            "game_hf": "",
            "game_image": "",
            "icon": "icon",
            "in_game": False,
            "game_updated": True,
            "start": self.previous_format_dict["start"],
        }
        self.windows = gw.getAllTitles()
        for window in self.windows:
            if window in self.assets["games"]:
                self.format_dict["game_hf"] = window
                self.format_dict["game_image"] = self.assets["games"][window]["image"]
                self.format_dict["in_game"] = True
        if self.format_dict != self.previous_format_dict:
            self.format_dict["start"] = time.time()
        self.previous_format_dict = self.format_dict
        return self.format_dict

    def presence_gen(self, format_dict):
        self.presence_dict = {"start": format_dict["start"]}
        if format_dict["in_game"]:
            for field in list(self.config["In Menu"].keys()):
                self.presence_dict[field] = self.config["In Game"][field].format(
                    **self.format_dict
                )
        else:
            for field in list(self.config["In Game"].keys()):
                self.presence_dict[field] = self.config["In Menu"][field].format(
                    **self.format_dict
                )
        for field in list(self.presence_dict.keys()):
            if self.presence_dict[field] == "" or self.presence_dict[field] == []:
                self.presence_dict[field] = None
        return self.presence_dict

os.chdir(sys.path[0])
close_on_close = len(sys.argv) > 1 and sys.argv[1] == "bkgrnd"

rich_presence()
