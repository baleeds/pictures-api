alias Pictures.{
  Repo,
  Picture,
  Gallery
}

Repo.insert!(%Picture{
  name: "Rainbow monsters",
  url: "https://static.familyjr.ca/rendition/4293/1058/595",
  size: 89107
})

Repo.insert!(%Picture{
  name: "Construction crew",
  url:
    "https://vignette.wikia.nocookie.net/spongebob/images/2/22/My_Pretty_Seahorse_19.jpg/revision/latest?cb=20111015224125",
  size: 105_706
})

Repo.insert!(%Picture{
  name: "I'll be back",
  url:
    "https://cdn1.thr.com/sites/default/files/imagecache/scale_crop_768_433/2018/01/the_terminator_still.jpg",
  size: 47862
})

Repo.insert!(%Picture{
  name: "Harry Spotter",
  url: "https://pics.me.me/harry-spotter-do-you-even-leviosa-um-why-tho-39540925.png",
  size: 149_847
})

Repo.insert!(%Picture{
  name: "Lit",
  url:
    "https://www.awn.com/sites/default/files/styles/original/public/image/featured/1027753-tom-and-jerry-blamed-mid-east-violence.jpg?itok=Hyqev1zp",
  size: 77598
})

Repo.insert!(%Gallery{
  name: "Gallery 1",
  description: "Yep",
})