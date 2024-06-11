const express = require('express')
const app = express()
const port = 3000

app.use(express.json());

  friendsList = [
    { 'name': 'Denis', 'age': '23' },
    { 'name': 'Ivan', 'age': '18' },
    {'name' : 'Dima', 'age' : '9'},
    {'name' : 'Dionis', 'age' : '19'},
    {'name' : 'Max' , 'age' : '19'},
    {'name' : 'Vova' , 'age' : '20'},
    {'name' : 'Anastasia' , 'age' : '18'},
    {'name' : 'Maria' , 'age' : '19'},
    {'name' : 'Vlad' , 'age' : '20'}
]

app.get('/friends-list', (req, res) => {
    res.send(JSON.stringify(friendsList))
});

app.post('/friend-add', (req, res) => {
    const newFriend = req.body;
    if (newFriend.name && newFriend.age) {
        friendsList.push(newFriend);
        res.status(201).json(newFriend);
    } else {
        res.status(400).json({ error: 'Invalid friend data' });
    }
});
app.delete('/friend-delete/:name', (req, res) => {
  const friendName = req.params.name;
  friendsList = friendsList.filter(friend => friend.name !== friendName);

});

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
});