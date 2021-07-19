Original App Design Project - README Template
===

PartyPlay

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
PartyPlay provides an organized and streamlined interface through which a user can start a music session on a host device and then have other users join the session where they can share a music queue. Both the host and the invited users can suggest songs to add to the queue, with the possibility of users voting on suggestions in order to assign them higher priority. Currently playing songs can also be assigned a "skip" vote if some feel that the next song should be played already. The host has the highest priority vote, but users can "veto" a host choice with enough numbers. The current host can also "hand off" the session to another user if he/she has to leave, so the music session remains uninterrupted.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social/Music/Entertainment
- **Mobile:** Mobile-centered experience, connects to users spotify app and incorporates location to easily join sessions
- **Story:** Allows users to collaboratively curate songs for a social event. Gives everybody control over what is playing, not just the person connected to speakers.
- **Market:** Relatively large market among both youth and young adults. Sharing music is pretty much universal so there could be many uses for such a platform.
- **Habit:** The average user "creates" sessions for use, so not really a habit-inducing app but definitely convenient in scenarios where many people want to listen to music together. Frequency of use depends on how often user listens to music with friends.
- **Scope:** It will be technically challenging to adopt the Spotify API and design the shared host/follower session structure. I can also forsee lots of networking challenges that might come up with streaming songs from a shared network. I feel that the goal is pretty defined in terms of functionality but there is a lot of work to be done in terms of design and how I want the UI to look.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can login to app
* User can link account with Spotify
* User can create a shared music session
* User can join an existing shared music session
* User can add a song suggestion to the shared queue
* User can remove(their own) song suggestion from the shared queue
* User can "like/upvote" existing suggestion in the queue
* User can dislike/downvote existing suggestion in the queue
* ...

**Optional Nice-to-have Stories**

* User can perform an "easy join" based on location data
* User can vote to "skip" a currently playing song
* User can vote to "replay" a currently playing song
* User can "hand off" host priveleges to another user
* User can add a playlist suggestion to the shared queue (playlist is added as an ordered sequence of songs)
* User can set a "Kids Mode" where available songs are filtered by explicit tag
* User with host priveleges can adjust voting settings (what proportion needed for skip/add/replay) during a session
* User can view "End of session stats", that displays information about which user had the most upvoted songs, least upvoted songs, "most aux friendly", etc
* User stats can get stored in "account info" after session for others to view, including things like "most suggested artist", "most sugggested song", "favorite decade", etc
* "Spotify-less" users can be invited (TECHNICAL PROBLEM)
* Apple music support (TECHNICAL PROBLEM)
* Live Updating Queue (TECHNICAL PROBLEM)
* ...

### 2. Screen Archetypes

* Registration screen
   * User can register for a new account
   * ...
* Login screen
   * User can login to their account
   * ...
* Home Screen
    * User can create a new session or join an existing session
* Personal Profile screen
    * User can view information about their account and session history
* Host Screen
    * User can invite users to the session 
    * User can connect to Spotify account and control shared queue
* Non-host Screen
    * User can invite users to the session
    * User can suggest songs to add to the shared queue
* Search screen
    * User can search for songs to suggest(non-host) or add (host)
* Settings screen
    * User can set default session settings (voting proportions, session sizes, etc)
* Now Playing screen for Host*

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Screen(join or create session)
* Personal profile screen
* Settings screen

**Flow Navigation** (Screen to Screen)

* Registration screen
   * Home screen
* Login screen
   * Home screen
* Home screen
    * Host Screen
    * Non-host Screen
* Personal Profile screen
    * none
* Settings screen
    * none
* Host Screen
    * Search screen
* Non-host Screen
    * Search screen
    


## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://github.com/santiramos27/PartyPlay/blob/main/Wireframes.pdf" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
