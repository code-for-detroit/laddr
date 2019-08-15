{extends "designs/site.tpl"}

{block title}{_ 'Events'} &mdash; {$dwoo.parent}{/block}

{block content}
    <header class="page-header">
        <div class="btn-toolbar pull-right">
            {if $.User}
                <form action="/events/create">
                    <button class="btn btn-success" type="submit">{icon "plus"}&nbsp;{_ "Add Event&hellip;"}</button>
                </form>
            {/if}
        </div>
        <h1>{_ "Events"} <span class="badge badge-secondary badge-pill">{$total|number_format}</span></h1>
    </header>

    {$starUrl = explode('*', $.server.REQUEST_URI)}
    {$currentGroup = $starUrl[1]}

    <div class="row">
        <div class="col-sm-4 col-md-3">
            <div class="list-group">
                <a class="list-group-item list-group-item-action {tif $currentGroup=='past' ? active}" href="/events/*past">Past Events</a>
                <a class="list-group-item list-group-item-action {tif $currentGroup=='upcoming' || $currentGroup=='' ? active}" href="/events/*upcoming">Upcoming Events</a>
                <a class="list-group-item list-group-item-action {tif $currentGroup=='all' ? active}" href="/events/*all">All Events</a>
            </div>
        </div>
        <div class="col-sm-8 col-md-9">
            {foreach item=Event from=$data}
                <article class="post card mb-4">
                    <div class="card-body">
                        <h2 class="card-title">
                            <a name="{$Event->Handle}" href="{$Event->getUrl()}">{$Event->Title|escape}</a>
                        </h2>
                        <ul class="row list-unstyled">
                            {if $Event->Status != 'published'}
                                <li class="col-md-3">
                                    <p>
                                        <b>Status</b><br/>
                                        {$Event->Status}
                                    </p>
                                </li>
                            {/if}

                            <li class="col-md-3">
                                <p>
                                    <b>Start time</b><br/>
                                    {timestamp $Event->StartTime time=yes}
                                </p>
                            </li>

                            {if $Event->EndTime}
                            <li class="col-md-3">
                                <p>
                                    <b>End time</b><br/>
                                    {timestamp $Event->EndTime time=yes}
                                </p>
                            </li>
                            {/if}

                            {if $Event->Location}
                            <li class="col-md-3">
                                <p>
                                    <b>Location</b><br/>
                                    <a href="https://www.google.com/maps?q={$Event->Location|escape:url}">{$Event->Location|escape}</a>
                                </p>
                            </li>
                            {/if}
                        </ul>
                        {if $Event->Description}
                            <div class="well">
                                <div class="content-markdown event-description">{$Event->Description|truncate:600|escape|markdown}</div>
                            </div>
                        {/if}
                    </div>
                </article>
            {foreachelse}
                <p><em>No events were found, try creating one{if count($conditions)} or <a href="?">browse without any filters</a>{/if}.</em></p>
            {/foreach}
        </div>
    </div>
{/block}
