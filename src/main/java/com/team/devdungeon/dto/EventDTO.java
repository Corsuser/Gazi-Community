package com.team.devdungeon.dto;

import lombok.Data;

@Data
public class EventDTO {
    private int status_no, event_no, tag_no, event_player, writtenNo;
    private String event_title, event_content, event_date, event_update, event_end, event_file_name;
}
