# Notes

## Summary of work
- I integrated most of the `flyctl status` output to the interface with the exception of the deployment ID which I didn't feel was useful to the user. 
- I added the url and the IP of the app in the header for convenience
- I added a client-side loop to the JS LiveView hooks that refreshes the interface every 2.5s and stops refreshing when the window is hidden (document.hidden === true).
- I created some components for common UI components
- I made style changes to help readability by changing the background color, changing font colors and  changing alignment of text and containers.

## Ideas for improvement

### UX
- Make UI refreshes more obvious by highlighting recently added elements or elements that have changed
- Make sure all edge and failure cases are handled correctly
- Make sure relative timestamps take into account user timezones
- Show user initials when the user has no avatar in the timeline
- Option to show screenshot or iframe of live app that refreshes 

### Developer experience
- Turn common elements (layouts, containers, buttons, titles...) into shared components
- Consider using separate .graphql/.gql files so that VS Code GraphQL extensions can be used for autocomplete/validation (until better support exists in .heex files)

### Feature ideas
- The ability to see logs directly in this interface would be very convenient and useful -- especially for those on the move that may want to take a peek on their phones
- Optional JS error logs that refresh
- Basic instance performance/usage metrics (similar to LiveDashboard)
- SSH/console access to VMs
- Database GUI 

## Assessing feature success
To determine feature success I'd want to look at few metrics and try to get feedback from users.

### Time spent on page per user
How many users are keeping the page open for a while?

### Number of sessions per user
Are users using the feature multiple times and how many users are using the feature?

### User feedback
From community forums or elsewhere on the internet or direct messages to users open to it.