import discord
from discord import app_commands
import random

# สร้าง client กับ Intents
intents = discord.Intents.default()
intents.members = True  # เปิดการเข้าถึงข้อมูลสมาชิก

# สร้าง Client
client = discord.Client(intents=intents)

# สร้าง tree สำหรับคำสั่ง Slash
@app_commands.command(name='randomuser', description='สุ่มสมาชิกจากห้อง')
async def random_user(interaction: discord.Interaction, count: int = 1):
    # ตรวจสอบว่าจำนวนไม่เกินจำนวนสมาชิกในห้อง
    if count < 1:
        await interaction.response.send_message("กรุณากำหนดจำนวนที่มากกว่าหรือเท่ากับ 1")
        return

    # ดึงสมาชิกจากช่องที่มีการใช้งานคำสั่ง
    channel = interaction.channel
    members = [member for member in channel.members if not member.bot]

    # ตรวจสอบว่ามีสมาชิกที่ไม่ใช่บอทในห้อง
    if not members:
        await interaction.response.send_message("ไม่มีสมาชิกในห้องนี้")
        return

    # สุ่มสมาชิกตามจำนวนที่ระบุ
    random_members = random.sample(members, min(count, len(members)))

    # สร้างข้อความที่บอทจะตอบกลับ
    names = '\n'.join([member.name for member in random_members])
    await interaction.response.send_message(f'สมาชิกที่สุ่มได้:\n{names}')

# ฟังก์ชันเมื่อบอทพร้อมใช้งาน
@client.event
async def on_ready():
    print(f'Logged in as {client.user}')
    # ตรวจสอบว่า Slash Command ได้ถูกลงทะเบียนหรือไม่
    await client.tree.sync()

# เริ่มต้นบอท
client.run('MTI5ODIwNjU3NjY2NTk1MjI4Nw.GmohE8.c3NWJ-7D-1zwE2ANV6OA1CI3hS56v3CLWQhF9E')

