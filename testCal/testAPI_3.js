const fs = require('fs');
const readline = require('readline');
const {google} = require('googleapis');
//var googleAuth = require('google-auth-library');
var moment=require('moment');
// If modifying these scopes, delete token.json.
const SCOPES = ['https://www.googleapis.com/auth/calendar.readonly',
                'https://www.googleapis.com/auth/calendar'
                ];

const TOKEN_PATH = 'token2.json';
var summaryText = 'test';
var startText = '201905010000';
var endText = '201905312359';

requestGoogle('list', moment().format('YYYY-MM-DDTHH:mm:ss+09:00'),
                      moment().add(12,'hours').format('YYYY-MM-DDTHH:mm:ss+09:00'))
console.log(moment().format('YYYY-MM-DDTHH:mm:SS+09:00'));
// requestGoogle('insert','google2',
//               moment('201905202000','YYYYMMDDHHmmSS').format('YYYY-MM-DDTHH:mm:SS+09:00'),
//               moment('201905202100','YYYYMMDDHHmmSS').format('YYYY-MM-DDTHH:mm:SS+09:00'));

// requestGoogle('delete',summaryText,
//               moment(startText,'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00'),
//               moment(endText,'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00')
  //          );
//console.log( moment(startText,'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00'));
//console.log( moment(endText,'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00'));
//console.log( moment(new Date()).format('YYYY-MM-DDTHH:mm:SS+09:00'));
// requestGoogle('list', moment(startText,'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00'),
//                       moment(endText,'YYYYMMDDHHmm').format('YYYY-MM-DDTHH:mm:SS+09:00')  );
function requestGoogle(command) {
  fs.readFile('client_secret.json', (err, content) => {
    if (err) return console.log('Error loading client secret file:', err);
    // Authorize a client with credentials, then call the Google Calendar API.

    if(command == 'list') authorize(JSON.parse(content), listEvents,arguments[1],arguments[2]);
    else if(command == 'insert') authorize(JSON.parse(content), insertEvents,arguments[1],arguments[2],arguments[3]);
    else if(command == 'delete') authorize(JSON.parse(content), deleteEvents,arguments[1],arguments[2],arguments[3]);

  });
}

function authorize(credentials, callback) {
  const {client_secret, client_id, redirect_uris} = credentials.installed;
  const oAuth2Client = new google.auth.OAuth2(
      client_id, client_secret, redirect_uris[0]);

  // Check if we have previously stored a token.
  fs.readFile(TOKEN_PATH, (err, token) => {
    if (err) return getAccessToken(oAuth2Client, callback);
    oAuth2Client.setCredentials(JSON.parse(token));
    if(callback==listEvents) callback(oAuth2Client,arguments[2],arguments[3]);
    else if(callback==insertEvents) callback(oAuth2Client,arguments[2],arguments[3],arguments[4]);
    else if(callback==deleteEvents) callback(oAuth2Client,arguments[2],arguments[3],arguments[4]);
  });
}


function getAccessToken(oAuth2Client, callback) {
  const authUrl = oAuth2Client.generateAuthUrl({
    access_type: 'offline',
    scope: SCOPES,
  });
  console.log('Authorize this app by visiting this url:', authUrl);
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });
  rl.question('Enter the code from that page here: ', (code) => {
    rl.close();
    oAuth2Client.getToken(code, (err, token) => {
      if (err) return console.error('Error retrieving access token', err);
      oAuth2Client.setCredentials(token);
      // Store the token to disk for later program executions
      fs.writeFile(TOKEN_PATH, JSON.stringify(token), (err) => {
        if (err) return console.error(err);
        console.log('Token stored to', TOKEN_PATH);
      });
      callback(oAuth2Client);
    });
  });
}

/**
 * Lists the next 10 events on the user's primary calendar.
 * @param {google.auth.OAuth2} auth An authorized OAuth2 client.
 */
function listEvents(auth,start,end) {
  const calendar = google.calendar({version: 'v3', auth});
  //console.log('now : '+now);
  calendar.events.list({
    calendarId: 'primary',
    timeMin:start,
    timeMax:end,
    // maxResults: 10,
    // singleEvents: true,
    // orderBy: 'startTime',
  }, (err, res) => {
    if (err) return console.log('The API returned an error: ' + err);
    const events = res.data.items;
    console.log(new Date());
    if (events.length) {
      console.log('Upcoming 10 events:');
      events.map((event, i) => {
        const start = event.start.dateTime || event.start.date;
        console.log('%s - %s ', start, event.summary);
      });
    } else {
      console.log('No upcoming events found.');
    }
  });
}
function deleteEvents(auth,text,start,end) {
  const calendar = google.calendar({version: 'v3', auth});
  calendar.events.list({
    calendarId: 'primary',
    timeMin:start,
    timeMax:end,
    singleEvents: true,
    orderBy: 'startTime',
  }, (err, res) => {
    if (err) return console.log('The API returned an error: ' + err);
    const events = res.data.items;
    if (events.length) {
      events.map((event, i) => {
        console.log(event.summary+event.id);
        if(event.summary == text) {
          calendar.events.delete({
            calendarId: 'primary',
            eventId:event.id
          },(err,res)=>{
            if(err) return console.log('The API returned an error: ' + err);
            console.log('delete'+res.toString());
          });
        }
      });
    } else {
      console.log('No upcoming events found.');
    }
  });


}
function insertEvents(auth,text,t_start,t_end) {
  const calendar = google.calendar({version: 'v3', auth});
  var event = {
   summary: text,
   start: {
     dateTime: t_start,
   },
   end: {
     dateTime:t_end,
   }
 };
  calendar.events.insert({
    calendarId : 'primary',
    resource : event
  },(err,res)=>{
    if(err) return console.log('quickAdd error : '+err);
    console.log('test create');
  });
}
