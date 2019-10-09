module.exports = async function(req,res){
    console.log('Listing out all users now...')
    
    const users = await User.find({})

    //silly soulition

    // const objs = []
    // users.forEach(user =>{objs.push({
    //     id:user.id,
    //     fullName: user.fullName,
    //     email:user.emailAddress

    //     })
    // })
    res.send(users)
}