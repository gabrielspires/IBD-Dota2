-- Creator:       MySQL Workbench 6.3.8/ExportSQLite Plugin 0.1.0
-- Author:        Gabriel
-- Caption:       New Model
-- Project:       Name of the project
-- Changed:       2019-06-22 12:21
-- Created:       2019-06-20 17:57
PRAGMA foreign_keys = OFF;

-- Schema: ibd_dota2
ATTACH "ibd_dota2.sdb" AS "ibd_dota2";
BEGIN;
CREATE TABLE "xp_reasons"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "name" VARCHAR(45) NOT NULL
);
CREATE TABLE "lobby_type"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "name" VARCHAR(45) NOT NULL
);
CREATE TABLE "item_ids"(
  "id" INTEGER NOT NULL,
  "name" VARCHAR(45) NOT NULL,
  PRIMARY KEY("id","name")
);
CREATE TABLE "gold_reasons"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "name" VARCHAR(45) NOT NULL
);
CREATE TABLE "order_types"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "name" VARCHAR(45) NOT NULL
);
CREATE TABLE "game_mode"(
  "id" INTEGER PRIMARY KEY NOT NULL,
  "name" VARCHAR(45) NOT NULL
);
CREATE TABLE "match"(
  "match_id" INTEGER PRIMARY KEY NOT NULL,
  "game_mode" INTEGER NOT NULL,
  "lobby_type" INTEGER NOT NULL,
  "radiant_win" BOOL NOT NULL,
  "duration" INTEGER NOT NULL,
  "human_players" INTEGER NOT NULL,
  "tower_status_dire" INTEGER NOT NULL,
  "towre_status_radiant" INTEGER NOT NULL,
  "barracks_status_radiant" INTEGER NOT NULL,
  "barracks_status_dire" INTEGER NOT NULL,
  "first_blood_time" INTEGER NOT NULL,
  CONSTRAINT "game_mode"
    FOREIGN KEY("game_mode")
    REFERENCES "game_mode"("id"),
  CONSTRAINT "lobby_type"
    FOREIGN KEY("lobby_type")
    REFERENCES "lobby_type"("id")
);
CREATE INDEX "match.game_mode_idx" ON "match" ("game_mode");
CREATE INDEX "match.lobby_type_idx" ON "match" ("lobby_type");
CREATE TABLE "player"(
  "player_match_id" INTEGER NOT NULL,
  "gold_spent" INTEGER NOT NULL,
  "gold" INTEGER NOT NULL,
  "xp_per_min" INTEGER NOT NULL,
  "level" INTEGER NOT NULL,
  "hero_id" INTEGER NOT NULL,
  "hero_healing" INTEGER NOT NULL,
  "hero_damage" INTEGER NOT NULL,
  "leaver_status" INTEGER NOT NULL,
  "tower_damage" INTEGER NOT NULL,
  "last_hits" INTEGER NOT NULL,
  "kills" INTEGER NOT NULL,
  "denies" INTEGER NOT NULL,
  "deaths" INTEGER NOT NULL,
  "gold_per_min" INTEGER NOT NULL,
  "item_0" INTEGER NOT NULL,
  "item_1" INTEGER NOT NULL,
  "item_2" INTEGER NOT NULL,
  "item_3" INTEGER NOT NULL,
  "item_4" INTEGER NOT NULL,
  "item_5" INTEGER NOT NULL,
  "assists" INTEGER NOT NULL,
  "account_id" INTEGER NOT NULL,
  PRIMARY KEY("account_id","player_match_id"),
  CONSTRAINT "player_match_id"
    FOREIGN KEY("player_match_id")
    REFERENCES "match"("match_id")
);
CREATE INDEX "player.player_match_id_idx" ON "player" ("player_match_id");
CREATE TABLE "chat"(
  "chat_match_id" INTEGER NOT NULL,
  "chat_id" INTEGER PRIMARY KEY NOT NULL,
  "time" INTEGER NOT NULL,
  "type" VARCHAR(45) NOT NULL,
  "unit" VARCHAR(45) NOT NULL,
  "key" VARCHAR(45) NOT NULL,
  "slot" INTEGER NOT NULL,
  CONSTRAINT "chat_match_id"
    FOREIGN KEY("chat_match_id")
    REFERENCES "match"("match_id")
);
CREATE TABLE "sen"(
  "sen_match_id" INTEGER NOT NULL,
  "sen_account_id" INTEGER NOT NULL,
  "x_pos" INTEGER NOT NULL,
  "y_pos" INTEGER NOT NULL,
  "sen_count" INTEGER NOT NULL,
  PRIMARY KEY("sen_match_id","sen_account_id","x_pos","y_pos"),
  CONSTRAINT "sen_match_id"
    FOREIGN KEY("sen_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "sen_account_id"
    FOREIGN KEY("sen_account_id")
    REFERENCES "player"("account_id")
);
CREATE INDEX "sen.sen_account_id_idx" ON "sen" ("sen_account_id");
CREATE TABLE "obs"(
  "obs_match_id" INTEGER NOT NULL,
  "obs_account_id" INTEGER NOT NULL,
  "x_pos" INTEGER NOT NULL,
  "y_pos" INTEGER NOT NULL,
  "obs_count" INTEGER NOT NULL,
  PRIMARY KEY("obs_match_id","obs_account_id","x_pos","y_pos"),
  CONSTRAINT "obs_match_id"
    FOREIGN KEY("obs_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "obs_account_id"
    FOREIGN KEY("obs_account_id")
    REFERENCES "player"("account_id")
);
CREATE INDEX "obs.obs_account_id_idx" ON "obs" ("obs_account_id");
CREATE TABLE "lane_pos"(
  "pos_match_id" INTEGER NOT NULL,
  "pos_account_id" INTEGER NOT NULL,
  "x_pos" INTEGER NOT NULL,
  "y_pos" INTEGER NOT NULL,
  "pos_count" INTEGER NOT NULL,
  PRIMARY KEY("pos_match_id","pos_account_id","x_pos","y_pos"),
  CONSTRAINT "pos_match_id"
    FOREIGN KEY("pos_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "pos_account_id"
    FOREIGN KEY("pos_account_id")
    REFERENCES "player"("account_id")
);
CREATE INDEX "lane_pos.pos_account_id_idx" ON "lane_pos" ("pos_account_id");
CREATE TABLE "healing"(
  "healing_match_id" INTEGER NOT NULL,
  "healing_account_id" INTEGER NOT NULL,
  "unit_healed" INTEGER NOT NULL,
  "healing_count" INTEGER NOT NULL,
  PRIMARY KEY("healing_match_id","healing_account_id","unit_healed"),
  CONSTRAINT "healing_match_id"
    FOREIGN KEY("healing_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "healing_account_id"
    FOREIGN KEY("healing_account_id")
    REFERENCES "player"("account_id")
);
CREATE INDEX "healing.healing_account_id_idx" ON "healing" ("healing_account_id");
CREATE TABLE "killed"(
  "killed_match_id" INTEGER NOT NULL,
  "killed_account_id" INTEGER NOT NULL,
  "unit_killed" INTEGER NOT NULL,
  "killed_count" INTEGER NOT NULL,
  PRIMARY KEY("killed_match_id","killed_account_id","unit_killed"),
  CONSTRAINT "killed_match_id"
    FOREIGN KEY("killed_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "killed_account_id"
    FOREIGN KEY("killed_account_id")
    REFERENCES "player"("account_id")
);
CREATE INDEX "killed.killed_account_id_idx" ON "killed" ("killed_account_id");
CREATE TABLE "player_gold_reasons"(
  "gold_match_id" INTEGER NOT NULL,
  "gold_account_id" INTEGER NOT NULL,
  "gold_id" INTEGER NOT NULL,
  "gold_count" INTEGER NOT NULL,
  PRIMARY KEY("gold_match_id","gold_account_id","gold_id"),
  CONSTRAINT "gold_match_id"
    FOREIGN KEY("gold_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "gold_account_id"
    FOREIGN KEY("gold_account_id")
    REFERENCES "player"("account_id"),
  CONSTRAINT "gold_id"
    FOREIGN KEY("gold_id")
    REFERENCES "gold_reasons"("id")
);
CREATE INDEX "player_gold_reasons.gold_account_id_idx" ON "player_gold_reasons" ("gold_account_id");
CREATE INDEX "player_gold_reasons.gold_id_idx" ON "player_gold_reasons" ("gold_id");
CREATE TABLE "item_uses"(
  "item_match_id" INTEGER NOT NULL,
  "item_account_id" INTEGER NOT NULL,
  "item_name" VARCHAR(45) NOT NULL,
  "item_count" INTEGER NOT NULL,
  PRIMARY KEY("item_match_id","item_account_id","item_name"),
  CONSTRAINT "item_match_id"
    FOREIGN KEY("item_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "item_account_id"
    FOREIGN KEY("item_account_id")
    REFERENCES "player"("account_id"),
  CONSTRAINT "item_name"
    FOREIGN KEY("item_name")
    REFERENCES "item_ids"("name")
);
CREATE INDEX "item_uses.item_account_id_idx" ON "item_uses" ("item_account_id");
CREATE INDEX "item_uses.item_name_idx" ON "item_uses" ("item_name");
CREATE TABLE "damage"(
  "damage_match_id" INTEGER NOT NULL,
  "damage_account_id" INTEGER NOT NULL,
  "unit_damaged" INTEGER NOT NULL,
  "damage_count" INTEGER NOT NULL,
  PRIMARY KEY("damage_match_id","damage_account_id","unit_damaged"),
  CONSTRAINT "damage_match_id"
    FOREIGN KEY("damage_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "damage_account_id"
    FOREIGN KEY("damage_account_id")
    REFERENCES "player"("account_id")
);
CREATE INDEX "damage.damage_account_id_idx" ON "damage" ("damage_account_id");
CREATE TABLE "actions"(
  "action_match_id" INTEGER NOT NULL,
  "action_account_id" INTEGER NOT NULL,
  "action_id" INTEGER NOT NULL,
  "action_count" INTEGER NOT NULL,
  PRIMARY KEY("action_match_id","action_account_id","action_id"),
  CONSTRAINT "action_match_id"
    FOREIGN KEY("action_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "action_account_id"
    FOREIGN KEY("action_account_id")
    REFERENCES "player"("account_id"),
  CONSTRAINT "action_id"
    FOREIGN KEY("action_id")
    REFERENCES "order_types"("id")
);
CREATE INDEX "actions.action_account_id_idx" ON "actions" ("action_account_id");
CREATE INDEX "actions.action_id_idx" ON "actions" ("action_id");
CREATE TABLE "player_xp_reasons"(
  "xp_match_id" INTEGER NOT NULL,
  "xp_account_id" INTEGER NOT NULL,
  "xp_id" INTEGER NOT NULL,
  "xp_count" INTEGER NOT NULL,
  PRIMARY KEY("xp_match_id","xp_account_id","xp_id"),
  CONSTRAINT "xp_match_id"
    FOREIGN KEY("xp_match_id")
    REFERENCES "player"("player_match_id"),
  CONSTRAINT "xp_account_id"
    FOREIGN KEY("xp_account_id")
    REFERENCES "player"("account_id"),
  CONSTRAINT "xp_id"
    FOREIGN KEY("xp_id")
    REFERENCES "xp_reasons"("id")
);
CREATE INDEX "player_xp_reasons.xp_account_id_idx" ON "player_xp_reasons" ("xp_account_id");
CREATE INDEX "player_xp_reasons.xp_id_idx" ON "player_xp_reasons" ("xp_id");
COMMIT;
